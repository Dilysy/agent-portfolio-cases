#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

find_ffmpeg() {
  local candidates=(
    "/usr/local/opt/ffmpeg-full/bin/ffmpeg"
    "/opt/homebrew/opt/ffmpeg-full/bin/ffmpeg"
    "/usr/local/bin/ffmpeg"
    "/opt/homebrew/bin/ffmpeg"
    "ffmpeg"
  )

  local candidate filters
  for candidate in "${candidates[@]}"; do
    if ! command -v "$candidate" >/dev/null 2>&1; then
      continue
    fi
    filters="$("$candidate" -hide_banner -filters 2>/dev/null || true)"
    if printf '%s\n' "$filters" | grep -Eq '(^|[[:space:]])ass[[:space:]]'; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

FFMPEG_BIN="$(find_ffmpeg || true)"
if [[ -z "${FFMPEG_BIN}" ]]; then
  echo "未找到支持 ass/libass 滤镜的 ffmpeg，停止，不覆盖正式视频。" >&2
  exit 1
fi

if ! command -v ffprobe >/dev/null 2>&1; then
  echo "未找到 ffprobe，停止，不覆盖正式视频。" >&2
  exit 1
fi

WORK_DIR="$(mktemp -d /tmp/final-subtitle-patch.XXXXXX)"
cleanup() {
  rm -rf "$WORK_DIR"
}
trap cleanup EXIT

write_subtitles() {
  local video="$1"
  local srt="$2"
  shift 2
  local lines=("$@")

  python3 - "$video" "$srt" "${lines[@]}" <<'PY'
from pathlib import Path
import subprocess
import sys

video = sys.argv[1]
srt = Path(sys.argv[2])
lines = sys.argv[3:]
duration = float(subprocess.check_output([
    "ffprobe", "-v", "error", "-show_entries", "format=duration",
    "-of", "default=nk=1:nw=1", video
], text=True).strip())

def ts(seconds: float) -> str:
    if seconds < 0:
        seconds = 0
    ms_total = int(round(seconds * 1000))
    h = ms_total // 3_600_000
    ms_total %= 3_600_000
    m = ms_total // 60_000
    ms_total %= 60_000
    s = ms_total // 1000
    ms = ms_total % 1000
    return f"{h:02d}:{m:02d}:{s:02d},{ms:03d}"

pad_start = min(0.8, duration * 0.02)
pad_end = min(1.2, duration * 0.03)
usable = max(duration - pad_start - pad_end, duration * 0.9)
segment = usable / len(lines)

srt.parent.mkdir(parents=True, exist_ok=True)
parts = []
for idx, text in enumerate(lines, start=1):
    start = pad_start + (idx - 1) * segment
    end = pad_start + idx * segment
    if idx == len(lines):
        end = min(duration - 0.3, duration)
    parts.append(f"{idx}\n{ts(start)} --> {ts(end)}\n{text}\n")
srt.write_text("\n".join(parts), encoding="utf-8")
PY
}

srt_to_ass() {
  local srt="$1"
  local ass="$2"
  python3 - "$srt" "$ass" <<'PY'
from pathlib import Path
import re
import sys

srt = Path(sys.argv[1])
ass = Path(sys.argv[2])
content = srt.read_text(encoding="utf-8").strip()

def ass_time(value: str) -> str:
    h, m, rest = value.split(":")
    s, ms = rest.split(",")
    cs = int(round(int(ms) / 10))
    if cs == 100:
        cs = 99
    return f"{int(h)}:{m}:{s}.{cs:02d}"

events = []
for block in re.split(r"\n\s*\n", content):
    lines = block.strip().splitlines()
    if len(lines) < 3:
        continue
    timing = lines[1]
    start, end = [x.strip() for x in timing.split("-->")]
    text = r"\N".join(lines[2:]).replace("{", "(").replace("}", ")")
    events.append((ass_time(start), ass_time(end), text))

header = """[Script Info]
ScriptType: v4.00+
PlayResX: 1920
PlayResY: 1080
ScaledBorderAndShadow: yes

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Default,PingFang SC,48,&H00FFFFFF,&H000000FF,&H00000000,&H96000000,0,0,0,0,100,100,0,0,1,3,0,2,80,80,54,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
"""
body = "".join(
    f"Dialogue: 0,{start},{end},Default,,0,0,0,,{text}\n"
    for start, end, text in events
)
ass.write_text(header + body, encoding="utf-8")
PY
}

burn_subtitles() {
  local name="$1"
  local video="$2"
  local backup="$3"
  local srt="$4"
  shift 4
  local lines=("$@")

  mkdir -p "$(dirname "$backup")" "$(dirname "$srt")"
  if [[ ! -s "$backup" ]]; then
    cp "$video" "$backup"
  fi

  write_subtitles "$video" "$srt" "${lines[@]}"
  local ass="$WORK_DIR/${name}.ass"
  srt_to_ass "$srt" "$ass"

  local tmp="$WORK_DIR/${name}-subtitled.mp4"
  "$FFMPEG_BIN" -y -i "$video" -vf "ass=$ass" \
    -c:v libx264 -pix_fmt yuv420p -crf 18 -preset medium \
    -c:a copy -movflags +faststart "$tmp"

  if [[ ! -s "$tmp" ]]; then
    echo "字幕烧录失败或输出文件为空：$name，停止，不覆盖正式视频。" >&2
    exit 1
  fi

  ffprobe -v error -select_streams v:0 \
    -show_entries stream=codec_name,width,height -of csv=p=0 "$tmp" >/dev/null

  local dims
  dims="$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0:s=x "$tmp")"
  if [[ "$dims" != "1920x1080" ]]; then
    echo "字幕输出分辨率不是 1920x1080：$name -> $dims，停止，不覆盖正式视频。" >&2
    exit 1
  fi

  mv "$tmp" "$video"
  echo "已生成中文字幕硬字幕版：$video"
}

burn_subtitles \
  "deep-research-agent" \
  "assets/demos/deep-research-agent/deep-research-agent-demo.mp4" \
  "assets/demos/deep-research-agent/backup/deep-research-agent-demo-nosub-backup.mp4" \
  "assets/reports/deep-research-agent/demo-subtitles-final.srt" \
  "自动化深度研究 Agent" \
  "拆解研究任务" \
  "搜索公开资料来源" \
  "汇总任务执行结果" \
  "生成结构化研究报告" \
  "研究结果需人工复核"

burn_subtitles \
  "database-query-agent" \
  "assets/demos/database-query-agent/database-query-agent-demo.mp4" \
  "assets/demos/database-query-agent/backup/database-query-agent-demo-nosub-backup.mp4" \
  "assets/reports/database-query-agent/demo-subtitles-final.srt" \
  "自然语言数据库查询 Agent" \
  "输入自然语言查询问题" \
  "理解业务数据结构" \
  "生成 SQL 查询逻辑" \
  "展示查询结果与风险边界" \
  "演示数据不连接真实企业数据库"

echo "全部缺字幕视频已完成硬字幕烧录。"
