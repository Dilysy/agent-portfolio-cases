#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

VIDEO="assets/demos/database-query-agent/raw/database-query-agent-raw-demo.mov"
SHOT_QUESTION="assets/screenshots/database-query-agent/raw/01-natural-language-question.png"
SHOT_SCHEMA="assets/screenshots/database-query-agent/raw/02-schema-example.png"
SHOT_SQL="assets/screenshots/database-query-agent/raw/03-generated-sql.png"
SHOT_RESULT_SECURITY="assets/screenshots/database-query-agent/raw/04-query-result-security.png"
SUBTITLES="assets/reports/database-query-agent/demo-subtitles.srt"
OUT_DIR="assets/demos/database-query-agent"
OUT="$OUT_DIR/database-query-agent-demo.mp4"

WORK_DIR="assets/reports/database-query-agent/.video-build"
SEGMENTS_FILE="$WORK_DIR/segments.txt"
BASE_VIDEO="$WORK_DIR/database-query-agent-demo-base.mp4"

require_file() {
  if [[ ! -f "$1" ]]; then
    echo "Missing input file: $1" >&2
    exit 1
  fi
}

require_file "$VIDEO"
require_file "$SHOT_QUESTION"
require_file "$SHOT_SCHEMA"
require_file "$SHOT_SQL"
require_file "$SHOT_RESULT_SECURITY"
require_file "$SUBTITLES"

mkdir -p "$OUT_DIR" "$WORK_DIR"
rm -f "$WORK_DIR"/segment-*.mp4 "$SEGMENTS_FILE" "$BASE_VIDEO" "$OUT"

make_image_segment() {
  local input="$1"
  local duration="$2"
  local output="$3"

  ffmpeg -y -hide_banner -loglevel error \
    -loop 1 -t "$duration" -i "$input" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=30" \
    -an \
    -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 \
    "$output"
}

make_video_segment() {
  local start="$1"
  local duration="$2"
  local output="$3"

  ffmpeg -y -hide_banner -loglevel error \
    -ss "$start" -t "$duration" -i "$VIDEO" \
    -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,fps=30" \
    -an \
    -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 \
    "$output"
}

# Target timeline, about 40 seconds:
# 00:00-00:04 title image
# 00:04-00:09 original overview
# 00:09-00:15 schema still
# 00:15-00:22 SQL still
# 00:22-00:30 original SQL/result/security section
# 00:30-00:37 result/security still
# 00:37-00:40 closing still
make_image_segment "$SHOT_QUESTION" 4 "$WORK_DIR/segment-01-title.mp4"
make_video_segment 0 5 "$WORK_DIR/segment-02-question.mp4"
make_image_segment "$SHOT_SCHEMA" 6 "$WORK_DIR/segment-03-schema.mp4"
make_image_segment "$SHOT_SQL" 7 "$WORK_DIR/segment-04-sql.mp4"
make_video_segment 6 8 "$WORK_DIR/segment-05-result.mp4"
make_image_segment "$SHOT_RESULT_SECURITY" 7 "$WORK_DIR/segment-06-security.mp4"
make_image_segment "$SHOT_RESULT_SECURITY" 3 "$WORK_DIR/segment-07-closing.mp4"

{
  echo "file 'segment-01-title.mp4'"
  echo "file 'segment-02-question.mp4'"
  echo "file 'segment-03-schema.mp4'"
  echo "file 'segment-04-sql.mp4'"
  echo "file 'segment-05-result.mp4'"
  echo "file 'segment-06-security.mp4'"
  echo "file 'segment-07-closing.mp4'"
} > "$SEGMENTS_FILE"

ffmpeg -y -hide_banner -loglevel error \
  -f concat -safe 0 -i "$SEGMENTS_FILE" \
  -an \
  -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 \
  "$BASE_VIDEO"

if ffmpeg -y -hide_banner -loglevel error \
  -i "$BASE_VIDEO" \
  -vf "subtitles=$SUBTITLES" \
  -an \
  -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 \
  "$OUT"; then
  echo "Created subtitled demo: $OUT"
else
  echo "Subtitle filter failed; falling back to no-subtitle output at formal path." >&2
  ffmpeg -y -hide_banner -loglevel error \
    -i "$BASE_VIDEO" \
    -an \
    -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 \
    "$OUT"
  echo "Created no-subtitle fallback demo: $OUT"
fi
