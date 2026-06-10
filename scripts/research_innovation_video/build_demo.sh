#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT_DIR"

RAW_DIR="assets/demos/research-innovation-agent/raw"
PREFERRED_VIDEO="$RAW_DIR/research-innovation-agent-raw-demo.mov"
SUBTITLES_SRT="assets/reports/research-innovation-agent/demo-subtitles.srt"
ENDING_FRAME="assets/reports/research-innovation-agent/frame-preview/frame-245s.png"
OUT_DIR="assets/demos/research-innovation-agent"
OUT="$OUT_DIR/research-innovation-agent-demo.mp4"

TMP_DIR="$(mktemp -d /tmp/research-innovation-video.XXXXXX)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

fail() {
  echo "$*" >&2
  exit 1
}

require_file() {
  local file="$1"
  [[ -f "$file" ]] || fail "缺少必需文件: $file"
}

find_ffmpeg() {
  local candidates=(
    "/usr/local/opt/ffmpeg-full/bin/ffmpeg"
    "/opt/homebrew/opt/ffmpeg-full/bin/ffmpeg"
    "/usr/local/bin/ffmpeg"
    "/opt/homebrew/bin/ffmpeg"
    "ffmpeg"
  )

  local candidate
  for candidate in "${candidates[@]}"; do
    local resolved=""
    if [[ "$candidate" == */* ]]; then
      [[ -x "$candidate" ]] && resolved="$candidate"
    elif command -v "$candidate" >/dev/null 2>&1; then
      resolved="$(command -v "$candidate")"
    fi

    if [[ -n "$resolved" ]]; then
      if "$resolved" -filters 2>/dev/null | grep -E " ass|subtitles" >/dev/null; then
        printf '%s\n' "$resolved"
        return 0
      fi
    fi
  done

  fail "未找到支持 ass/libass 的 ffmpeg，无法生成中文字幕硬字幕版。"
}

select_video() {
  if [[ -f "$PREFERRED_VIDEO" ]]; then
    printf '%s\n' "$PREFERRED_VIDEO"
    return 0
  fi

  mapfile -t videos < <(find "$RAW_DIR" -maxdepth 1 -type f \( -iname '*.mov' -o -iname '*.mp4' -o -iname '*.m4v' \) | sort)
  if [[ "${#videos[@]}" -eq 1 ]]; then
    printf '%s\n' "${videos[0]}"
    return 0
  fi

  fail "未找到唯一原始视频，请检查 $RAW_DIR。"
}

ffmpeg_concat_escape() {
  printf '%s' "$1" | sed "s/'/'\\\\''/g"
}

ass_escape_text() {
  sed -e 's/\\/\\\\/g' -e 's/{/\\{/g' -e 's/}/\\}/g'
}

generate_ass_from_srt() {
  local srt="$1"
  local ass="$2"

  python3 - "$srt" "$ass" <<'PY'
import re
import sys
from pathlib import Path

srt_path = Path(sys.argv[1])
ass_path = Path(sys.argv[2])

def convert_time(value: str) -> str:
    value = value.strip().replace(",", ".")
    hh, mm, rest = value.split(":")
    ss, ms = rest.split(".")
    centis = int(round(int(ms[:3].ljust(3, "0")) / 10))
    if centis >= 100:
        centis = 99
    return f"{int(hh)}:{int(mm):02d}:{int(ss):02d}.{centis:02d}"

content = srt_path.read_text(encoding="utf-8").strip()
blocks = re.split(r"\n\s*\n", content)
events = []
for block in blocks:
    lines = [line.rstrip() for line in block.splitlines() if line.strip()]
    if len(lines) < 3 or "-->" not in lines[1]:
        continue
    start_raw, end_raw = [part.strip() for part in lines[1].split("-->", 1)]
    text = r"\N".join(lines[2:])
    text = text.replace("\\", r"\\").replace("{", r"\{").replace("}", r"\}")
    events.append((convert_time(start_raw), convert_time(end_raw), text))

header = """[Script Info]
ScriptType: v4.00+
Collisions: Normal
PlayResX: 1920
PlayResY: 1080
WrapStyle: 2
ScaledBorderAndShadow: yes

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Default,PingFang SC,46,&H00FFFFFF,&H00FFFFFF,&H90000000,&H66000000,0,0,0,0,100,100,0,0,1,3,0,2,80,80,52,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
"""

body = "".join(
    f"Dialogue: 0,{start},{end},Default,,0,0,0,,{text}\n"
    for start, end, text in events
)
ass_path.write_text(header + body, encoding="utf-8")
PY
}

COMMON_SCALE="scale=w=1920:h=1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=white,setsar=1,fps=30,format=yuv420p"

make_video_segment() {
  local start="$1"
  local duration="$2"
  local speed="$3"
  local output="$4"

  "$FFMPEG" -hide_banner -y -loglevel error \
    -ss "$start" -t "$duration" -i "$VIDEO" \
    -vf "setpts=PTS/${speed},${COMMON_SCALE}" \
    -an -c:v libx264 -preset medium -crf 20 -movflags +faststart \
    "$output"
}

make_image_segment() {
  local image="$1"
  local duration="$2"
  local output="$3"

  "$FFMPEG" -hide_banner -y -loglevel error \
    -loop 1 -t "$duration" -i "$image" \
    -vf "$COMMON_SCALE" \
    -an -c:v libx264 -preset medium -crf 20 -movflags +faststart \
    "$output"
}

VIDEO="$(select_video)"
FFMPEG="$(find_ffmpeg)"

require_file "$VIDEO"
require_file "$SUBTITLES_SRT"
require_file "$ENDING_FRAME"

mkdir -p "$OUT_DIR"

ASS_FILE="$TMP_DIR/demo-subtitles.ass"
CONCAT_FILE="$TMP_DIR/concat.txt"
MERGED="$TMP_DIR/merged.mp4"
OUTPUT_TMP="$TMP_DIR/research-innovation-agent-demo.mp4"

generate_ass_from_srt "$SUBTITLES_SRT" "$ASS_FILE"
require_file "$ASS_FILE"

# 计划总时长约 82 秒。等待段只保留压缩片段，避免突出模型调用耗时。
make_video_segment "00:00:00" 7 1 "$TMP_DIR/segment-01-home.mp4"
make_video_segment "00:00:10" 8 1.25 "$TMP_DIR/segment-02-overview.mp4"
make_video_segment "00:00:25" 5 5 "$TMP_DIR/segment-03-hunter-wait.mp4"
make_video_segment "00:00:30" 10 1 "$TMP_DIR/segment-04-hunter-result.mp4"
make_video_segment "00:00:55" 4 1 "$TMP_DIR/segment-05-miner-input.mp4"
make_video_segment "00:01:00" 45 6 "$TMP_DIR/segment-06-miner-wait.mp4"
make_video_segment "00:01:50" 16 1 "$TMP_DIR/segment-07-miner-result.mp4"
make_video_segment "00:02:15" 6 1 "$TMP_DIR/segment-08-coach-input.mp4"
make_video_segment "00:02:25" 6 6 "$TMP_DIR/segment-09-coach-wait-start.mp4"
make_video_segment "00:03:35" 5 5 "$TMP_DIR/segment-10-coach-wait-end.mp4"
make_video_segment "00:03:40" 8 1 "$TMP_DIR/segment-11-coach-result.mp4"
make_video_segment "00:03:55" 5 5 "$TMP_DIR/segment-12-validator-wait.mp4"
make_video_segment "00:04:00" 8 1 "$TMP_DIR/segment-13-validator-result.mp4"
make_image_segment "$ENDING_FRAME" 5 "$TMP_DIR/segment-14-ending-hold.mp4"

for segment in "$TMP_DIR"/segment-*.mp4; do
  printf "file '%s'\n" "$(ffmpeg_concat_escape "$segment")" >> "$CONCAT_FILE"
done

"$FFMPEG" -hide_banner -y -loglevel error \
  -f concat -safe 0 -i "$CONCAT_FILE" \
  -c copy "$MERGED"

"$FFMPEG" -hide_banner -y -loglevel error \
  -i "$MERGED" \
  -vf "ass='${ASS_FILE}'" \
  -an -c:v libx264 -preset medium -crf 20 -movflags +faststart \
  "$OUTPUT_TMP"

if [[ ! -s "$OUTPUT_TMP" ]]; then
  fail "字幕烧录失败，未生成正式视频。"
fi

mv "$OUTPUT_TMP" "$OUT"
echo "已生成中文字幕硬字幕版: $OUT"
