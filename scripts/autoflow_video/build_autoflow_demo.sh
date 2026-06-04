#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

RAW_VIDEO="assets/demos/autoflow-agent/raw/autoflow-raw-demo.mov"
STANDARD_IMG="assets/screenshots/autoflow-agent/raw/standard-mode.png"
INSPIRATION_IMG="assets/screenshots/autoflow-agent/raw/inspiration-mode.png"
PLAN_IMG="assets/screenshots/autoflow-agent/raw/plan-mode.png"
CODE_IMG="assets/screenshots/autoflow-agent/raw/code-mode.png"
SUBTITLES="assets/reports/autoflow-agent/autoflow-demo-subtitles.srt"
OUTPUT="assets/demos/autoflow-agent/autoflow-agent-demo.mp4"
TMP_DIR="assets/demos/autoflow-agent/.autoflow-demo-build"
CONCAT_LIST="$TMP_DIR/concat-list.txt"
PYTHON_BIN="${PYTHON_BIN:-/Users/wangyu/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3}"

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is required but was not found in PATH." >&2
  exit 1
fi

if ! command -v ffprobe >/dev/null 2>&1; then
  echo "ffprobe is required but was not found in PATH." >&2
  exit 1
fi

for file in "$RAW_VIDEO" "$STANDARD_IMG" "$INSPIRATION_IMG" "$PLAN_IMG" "$CODE_IMG" "$SUBTITLES"; do
  if [[ ! -f "$file" ]]; then
    echo "Required file not found: $file" >&2
    exit 1
  fi
done

if [[ ! -x "$PYTHON_BIN" ]]; then
  echo "Python executable not found: $PYTHON_BIN" >&2
  exit 1
fi

mkdir -p "$TMP_DIR" "$(dirname "$OUTPUT")"
rm -f "$TMP_DIR"/*.mp4 "$CONCAT_LIST"
rm -f "$TMP_DIR"/subtitle-*.png

COMMON_VIDEO_FILTER="scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1,fps=30"
X264_ARGS=(-c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 -movflags +faststart)

make_image_clip() {
  local input="$1"
  local duration="$2"
  local output="$3"

  ffmpeg -hide_banner -y \
    -loop 1 -t "$duration" -i "$input" \
    -vf "$COMMON_VIDEO_FILTER" \
    -an "${X264_ARGS[@]}" "$output"
}

make_video_clip() {
  local start="$1"
  local end="$2"
  local speed="$3"
  local output="$4"
  local vf="$COMMON_VIDEO_FILTER"

  if [[ "$speed" != "1" ]]; then
    vf="setpts=PTS/${speed},${COMMON_VIDEO_FILTER}"
  fi

  ffmpeg -hide_banner -y \
    -ss "$start" -to "$end" -i "$RAW_VIDEO" \
    -vf "$vf" \
    -an "${X264_ARGS[@]}" "$output"
}

# 00:00-00:03 title
make_image_clip "$STANDARD_IMG" 3 "$TMP_DIR/00-title.mp4"

# 00:03-00:09 homepage / product structure
make_video_clip "00:00" "00:06" 1 "$TMP_DIR/01-homepage.mp4"

# 00:09-00:24 inspiration mode
make_video_clip "00:25" "00:40" 1 "$TMP_DIR/02-inspiration.mp4"

# 00:24-00:44 standard mode, accelerated 1.25x
make_video_clip "01:10" "01:35" 1.25 "$TMP_DIR/03-standard.mp4"

# 00:44-00:59 plan mode
make_video_clip "01:45" "02:00" 1 "$TMP_DIR/04-plan.mp4"

# 00:59-01:09 Mermaid code mode + export
make_video_clip "02:05" "02:15" 1 "$TMP_DIR/05-code-export.mp4"

# 01:09-01:12 ending
make_image_clip "$STANDARD_IMG" 3 "$TMP_DIR/06-ending.mp4"

cat > "$CONCAT_LIST" <<EOF
file '00-title.mp4'
file '01-homepage.mp4'
file '02-inspiration.mp4'
file '03-standard.mp4'
file '04-plan.mp4'
file '05-code-export.mp4'
file '06-ending.mp4'
EOF

ffmpeg -hide_banner -y \
  -f concat -safe 0 -i "$CONCAT_LIST" \
  -c copy "$TMP_DIR/autoflow-demo-silent.mp4"

"$PYTHON_BIN" - <<'PY'
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

out_dir = Path("assets/demos/autoflow-agent/.autoflow-demo-build")
font_candidates = [
    "/System/Library/Fonts/PingFang.ttc",
    "/System/Library/Fonts/STHeiti Medium.ttc",
    "/Library/Fonts/Arial Unicode.ttf",
]
font_path = next((p for p in font_candidates if Path(p).exists()), None)
font = ImageFont.truetype(font_path, 56) if font_path else ImageFont.load_default()

items = [
    ("subtitle-01.png", "AutoFlow 流程图生成 Agent"),
    ("subtitle-02.png", "自然语言生成流程图"),
    ("subtitle-03.png", "灵感模式：想法转流程"),
    ("subtitle-04.png", "标准模式：描述转图"),
    ("subtitle-05.png", "计划模式：拆解项目流程"),
    ("subtitle-06.png", "代码模式：实时预览与导出"),
    ("subtitle-07.png", "LLM 接入 / 四模式验证"),
]

for name, text in items:
    img = Image.new("RGBA", (1920, 1080), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    bbox = draw.textbbox((0, 0), text, font=font, stroke_width=3)
    w = bbox[2] - bbox[0]
    h = bbox[3] - bbox[1]
    x = (1920 - w) // 2
    y = 1080 - h - 72
    draw.text(
        (x, y),
        text,
        font=font,
        fill=(255, 255, 255, 255),
        stroke_width=3,
        stroke_fill=(0, 0, 0, 190),
    )
    img.save(out_dir / name)
PY

ffmpeg -hide_banner -y \
  -i "$TMP_DIR/autoflow-demo-silent.mp4" \
  -loop 1 -i "$TMP_DIR/subtitle-01.png" \
  -loop 1 -i "$TMP_DIR/subtitle-02.png" \
  -loop 1 -i "$TMP_DIR/subtitle-03.png" \
  -loop 1 -i "$TMP_DIR/subtitle-04.png" \
  -loop 1 -i "$TMP_DIR/subtitle-05.png" \
  -loop 1 -i "$TMP_DIR/subtitle-06.png" \
  -loop 1 -i "$TMP_DIR/subtitle-07.png" \
  -filter_complex "[0:v][1:v]overlay=0:0:enable='between(t,0,3)'[v1];[v1][2:v]overlay=0:0:enable='between(t,3,9)'[v2];[v2][3:v]overlay=0:0:enable='between(t,9,24)'[v3];[v3][4:v]overlay=0:0:enable='between(t,24,44)'[v4];[v4][5:v]overlay=0:0:enable='between(t,44,59)'[v5];[v5][6:v]overlay=0:0:enable='between(t,59,69)'[v6];[v6][7:v]overlay=0:0:enable='between(t,69,72)'[vout]" \
  -map "[vout]" -t 72 \
  -an "${X264_ARGS[@]}" "$OUTPUT"

echo "Generated: $OUTPUT"
ffprobe -hide_banner -loglevel error \
  -show_entries format=duration \
  -show_entries stream=codec_name,width,height \
  -of default=noprint_wrappers=1 "$OUTPUT"
