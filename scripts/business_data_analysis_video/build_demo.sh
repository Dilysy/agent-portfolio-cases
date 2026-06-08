#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT_DIR"

CSV="assets/reports/business-data-analysis-agent/sample-sales-data.csv"
REPORT_MD="assets/reports/business-data-analysis-agent/business-data-analysis-report.md"
SUBTITLES="assets/reports/business-data-analysis-agent/demo-subtitles.srt"

IMG_TITLE="assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png"
IMG_OVERVIEW="assets/screenshots/business-data-analysis-agent/final/05-report-overview.png"
IMG_TREND="assets/screenshots/business-data-analysis-agent/raw/01-sales-trend.png"
IMG_REGION="assets/screenshots/business-data-analysis-agent/raw/02-region-comparison.png"
IMG_CATEGORY="assets/screenshots/business-data-analysis-agent/raw/03-category-contribution.png"
IMG_CUSTOMER="assets/screenshots/business-data-analysis-agent/raw/04-customer-type-analysis.png"
IMG_INSIGHTS="assets/screenshots/business-data-analysis-agent/final/06-business-insights.png"

OUT_DIR="assets/demos/business-data-analysis-agent"
OUT="$OUT_DIR/business-data-analysis-agent-demo.mp4"

TMP_DIR="$(mktemp -d /tmp/business-data-analysis-video.XXXXXX)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$OUT_DIR"

missing=0
for f in "$CSV" "$REPORT_MD" "$SUBTITLES" "$IMG_TITLE" "$IMG_OVERVIEW" "$IMG_TREND" "$IMG_REGION" "$IMG_CATEGORY" "$IMG_CUSTOMER" "$IMG_INSIGHTS"; do
  if [[ ! -f "$f" ]]; then
    echo "缺少输入素材: $f" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo "请先补齐缺失素材，再执行剪辑脚本。" >&2
  exit 1
fi

command -v ffmpeg >/dev/null 2>&1 || {
  echo "未找到 ffmpeg，请先安装 ffmpeg。" >&2
  exit 1
}

python3 - "$SUBTITLES" "$TMP_DIR/subtitles" <<'PY'
import re
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

srt_path = Path(sys.argv[1])
out_dir = Path(sys.argv[2])
out_dir.mkdir(parents=True, exist_ok=True)

font_candidates = [
    "/System/Library/Fonts/PingFang.ttc",
    "/System/Library/Fonts/STHeiti Medium.ttc",
    "/System/Library/Fonts/Supplemental/Songti.ttc",
]
font_path = next((p for p in font_candidates if Path(p).exists()), None)
font = ImageFont.truetype(font_path, 42) if font_path else ImageFont.load_default()

content = srt_path.read_text(encoding="utf-8").strip()
blocks = re.split(r"\n\s*\n", content)
for idx, block in enumerate(blocks, 1):
    lines = [line.strip() for line in block.splitlines() if line.strip()]
    if len(lines) < 3:
        continue
    text = " ".join(lines[2:])
    img = Image.new("RGBA", (1920, 1080), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    try:
        bbox = draw.textbbox((0, 0), text, font=font, stroke_width=2)
        w = bbox[2] - bbox[0]
        h = bbox[3] - bbox[1]
    except AttributeError:
        w, h = draw.textsize(text, font=font)
    x = (1920 - w) // 2
    y = 1080 - 86 - h
    draw.text(
        (x, y),
        text,
        font=font,
        fill=(255, 255, 255, 255),
        stroke_width=2,
        stroke_fill=(0, 0, 0, 190),
    )
    img.save(out_dir / f"subtitle-{idx}.png")
PY

make_segment() {
  local image="$1"
  local duration="$2"
  local output="$3"

  ffmpeg -y -hide_banner -loglevel error \
    -loop 1 -t "$duration" -i "$image" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=white,setsar=1,fps=30" \
    -an -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    "$output"
}

make_segment "$IMG_TITLE" 5 "$TMP_DIR/segment-01.mp4"
make_segment "$IMG_OVERVIEW" 7 "$TMP_DIR/segment-02.mp4"
make_segment "$IMG_OVERVIEW" 8 "$TMP_DIR/segment-03.mp4"
make_segment "$IMG_TREND" 9 "$TMP_DIR/segment-04.mp4"
make_segment "$IMG_REGION" 9 "$TMP_DIR/segment-05.mp4"
make_segment "$IMG_CATEGORY" 9 "$TMP_DIR/segment-06.mp4"
make_segment "$IMG_CUSTOMER" 8 "$TMP_DIR/segment-07.mp4"
make_segment "$IMG_INSIGHTS" 8 "$TMP_DIR/segment-08.mp4"
make_segment "$IMG_TREND" 3 "$TMP_DIR/segment-09.mp4"

for n in 01 02 03 04 05 06 07 08 09; do
  printf "file '%s/segment-%s.mp4'\n" "$TMP_DIR" "$n" >> "$TMP_DIR/concat.txt"
done

ffmpeg -y -hide_banner -loglevel error \
  -f concat -safe 0 -i "$TMP_DIR/concat.txt" \
  -c copy "$TMP_DIR/base.mp4"

ffmpeg -y -hide_banner \
  -i "$TMP_DIR/base.mp4" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-1.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-2.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-3.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-4.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-5.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-6.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-7.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-8.png" \
  -loop 1 -i "$TMP_DIR/subtitles/subtitle-9.png" \
  -f lavfi -t 66 -i anullsrc=channel_layout=stereo:sample_rate=48000 \
  -filter_complex "[0:v][1:v]overlay=0:0:enable='between(t,0,5)'[v1];[v1][2:v]overlay=0:0:enable='between(t,5,12)'[v2];[v2][3:v]overlay=0:0:enable='between(t,12,20)'[v3];[v3][4:v]overlay=0:0:enable='between(t,20,29)'[v4];[v4][5:v]overlay=0:0:enable='between(t,29,38)'[v5];[v5][6:v]overlay=0:0:enable='between(t,38,47)'[v6];[v6][7:v]overlay=0:0:enable='between(t,47,55)'[v7];[v7][8:v]overlay=0:0:enable='between(t,55,63)'[v8];[v8][9:v]overlay=0:0:enable='between(t,63,66)'[vout]" \
  -map "[vout]" -map 10:a \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -shortest -movflags +faststart \
  "$OUT"

echo "已生成: $OUT"
