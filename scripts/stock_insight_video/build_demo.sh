#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

RAW_DIR="assets/demos/stock-insight-agent/raw"
PREFERRED_INPUT="$RAW_DIR/stock-insight-agent-raw-demo.mov"
SUBTITLE_SRT="assets/reports/stock-insight-agent/demo-subtitles.srt"
OUTPUT="assets/demos/stock-insight-agent/stock-insight-agent-demo.mp4"
WORK_DIR="assets/reports/stock-insight-agent/tmp-video-build"

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
    if command -v "$candidate" >/dev/null 2>&1; then
      local resolved
      resolved="$(command -v "$candidate")"
      if "$resolved" -hide_banner -filters 2>/dev/null | awk '{print $2}' | grep -qx "ass"; then
        printf '%s\n' "$resolved"
        return 0
      fi
      if "$resolved" -hide_banner -filters 2>/dev/null | awk '{print $2}' | grep -qx "subtitles"; then
        printf '%s\n' "$resolved"
        return 0
      fi
    fi
  done

  return 1
}

detect_input() {
  if [[ -f "$PREFERRED_INPUT" ]]; then
    printf '%s\n' "$PREFERRED_INPUT"
    return 0
  fi

  mapfile -t videos < <(find "$RAW_DIR" -maxdepth 1 -type f \( -iname '*.mov' -o -iname '*.mp4' -o -iname '*.m4v' -o -iname '*.webm' \) | sort)
  if [[ "${#videos[@]}" -eq 1 ]]; then
    printf '%s\n' "${videos[0]}"
    return 0
  fi

  echo "未找到主视频，或 raw 目录下存在多个视频文件，无法自动选择。" >&2
  return 1
}

escape_ass_path() {
  local path="$1"
  path="${path//\\/\\\\}"
  path="${path//:/\\:}"
  path="${path//\'/\\\'}"
  printf '%s\n' "$path"
}

FFMPEG="$(find_ffmpeg || true)"
if [[ -z "$FFMPEG" ]]; then
  echo "未找到支持 ass/libass 的 ffmpeg，无法生成中文字幕硬字幕版。" >&2
  exit 1
fi

if ! "$FFMPEG" -hide_banner -filters 2>/dev/null | awk '{print $2}' | grep -qx "ass"; then
  echo "未找到支持 ass/libass 的 ffmpeg，无法生成中文字幕硬字幕版。" >&2
  exit 1
fi

INPUT="$(detect_input)"
if [[ ! -f "$SUBTITLE_SRT" ]]; then
  echo "字幕文件不存在: $SUBTITLE_SRT" >&2
  exit 1
fi

mkdir -p "$WORK_DIR" "$(dirname "$OUTPUT")"
rm -f "$WORK_DIR"/segment-*.mp4 "$WORK_DIR/concat.txt" "$WORK_DIR/subtitles.ass" "$WORK_DIR/merged-nosub.mp4" "$OUTPUT"

make_segment() {
  local start="$1"
  local duration="$2"
  local output="$3"

  "$FFMPEG" -y -hide_banner -loglevel error \
    -ss "$start" -i "$INPUT" -t "$duration" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1,fps=30" \
    -an \
    -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    "$output"
}

make_segment "00:00:00" "6" "$WORK_DIR/segment-01-home.mp4"
make_segment "00:00:08" "17" "$WORK_DIR/segment-02-realtime.mp4"
make_segment "00:00:28" "14" "$WORK_DIR/segment-03-technical.mp4"
make_segment "00:00:45" "23.5" "$WORK_DIR/segment-04-risk.mp4"

cat > "$WORK_DIR/concat.txt" <<EOF
file 'segment-01-home.mp4'
file 'segment-02-realtime.mp4'
file 'segment-03-technical.mp4'
file 'segment-04-risk.mp4'
EOF

"$FFMPEG" -y -hide_banner -loglevel error \
  -f concat -safe 0 -i "$WORK_DIR/concat.txt" \
  -c copy "$WORK_DIR/merged-nosub.mp4"

"$FFMPEG" -y -hide_banner -loglevel error \
  -i "$SUBTITLE_SRT" "$WORK_DIR/subtitles.ass"

python3 - "$WORK_DIR/subtitles.ass" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text(encoding="utf-8", errors="replace")
lines = text.splitlines()
for idx, line in enumerate(lines):
    if line.startswith("Style: Default,"):
        fields = line.split(",")
        if len(fields) >= 23:
            fields[1] = "PingFang SC"
            fields[2] = "38"
            fields[3] = "&H00FFFFFF"
            fields[4] = "&H000000FF"
            fields[5] = "&H00000000"
            fields[6] = "&HAA000000"
            fields[16] = "2"
            fields[17] = "1"
            fields[18] = "0"
            fields[19] = "2"
            fields[20] = "80"
            fields[21] = "80"
            fields[22] = "54"
            lines[idx] = ",".join(fields)
        break
path.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY

ASS_FILTER_PATH="$(escape_ass_path "$WORK_DIR/subtitles.ass")"
"$FFMPEG" -y -hide_banner -loglevel error \
  -i "$WORK_DIR/merged-nosub.mp4" \
  -vf "ass='$ASS_FILTER_PATH'" \
  -an \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -movflags +faststart \
  "$OUTPUT"

if [[ ! -s "$OUTPUT" ]]; then
  echo "字幕烧录失败或输出文件为空，未生成正式视频。" >&2
  exit 1
fi

echo "已生成中文字幕硬字幕版: $OUTPUT"
