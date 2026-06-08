#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

VIDEO="assets/demos/deep-research-agent/raw/deep-research-agent-raw-demo.mov"
SHOT_TOPIC="assets/screenshots/deep-research-agent/raw/01-topic-input.png"
SHOT_SOURCES="assets/screenshots/deep-research-agent/raw/03-search-sources.png"
SHOT_SUMMARY="assets/screenshots/deep-research-agent/raw/04-task-summary.png"
SHOT_REPORT="assets/screenshots/deep-research-agent/raw/05-final-report.png"
SUBTITLES="assets/reports/deep-research-agent/demo-subtitles.srt"
OUTPUT="assets/demos/deep-research-agent/deep-research-agent-demo.mp4"
OUTPUT_NOSUB="assets/demos/deep-research-agent/deep-research-agent-demo-nosub.mp4"

WORKDIR="assets/reports/deep-research-agent/video-build-tmp"
CONCAT_FILE="$WORKDIR/concat.txt"

require_file() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
}

ffmpeg_escape_path() {
  printf '%s' "$1" | sed "s/'/'\\\\''/g"
}

require_file "$VIDEO"
require_file "$SHOT_TOPIC"
require_file "$SHOT_SOURCES"
require_file "$SHOT_SUMMARY"
require_file "$SHOT_REPORT"
require_file "$SUBTITLES"

TITLE_IMAGE="$SHOT_TOPIC"
ENDING_IMAGE="$SHOT_REPORT"

mkdir -p "$WORKDIR" "$(dirname "$OUTPUT")"
rm -f "$WORKDIR"/*.mp4 "$CONCAT_FILE"

COMMON_SCALE="scale=w=1920:h=1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=white,setsar=1,fps=30,format=yuv420p"

make_image_segment() {
  local image="$1"
  local duration="$2"
  local output="$3"

  ffmpeg -hide_banner -y \
    -loop 1 -t "$duration" -i "$image" \
    -vf "$COMMON_SCALE" \
    -an -c:v libx264 -preset medium -crf 18 -movflags +faststart \
    "$output"
}

make_video_segment() {
  local start="$1"
  local duration="$2"
  local speed="$3"
  local output="$4"

  ffmpeg -hide_banner -y \
    -ss "$start" -t "$duration" -i "$VIDEO" \
    -vf "setpts=PTS/${speed},$COMMON_SCALE" \
    -an -c:v libx264 -preset medium -crf 18 -movflags +faststart \
    "$output"
}

make_image_segment "$TITLE_IMAGE" 3 "$WORKDIR/segment-01-title.mp4"

# 00:00-00:12.5 at 1.25x => 10s
make_video_segment "00:00:00" 12.5 1.25 "$WORKDIR/segment-02-topic-input.mp4"

# 00:50-01:02 => 12s
make_video_segment "00:00:50" 12 1 "$WORKDIR/segment-03-todo-list.mp4"

# 01:15-01:27 => 12s
make_video_segment "00:01:15" 12 1 "$WORKDIR/segment-04-search-sources.mp4"

# 01:55-02:07 => 12s
make_video_segment "00:01:55" 12 1 "$WORKDIR/segment-05-task-summary.mp4"

# 02:25-02:40 at 1.25x => 12s
make_video_segment "00:02:25" 15 1.25 "$WORKDIR/segment-06-tool-records.mp4"

# 03:30-03:45 at 1.5x => 10s
make_video_segment "00:03:30" 15 1.5 "$WORKDIR/segment-07-completion-flow.mp4"

# 04:20-04:32 => 12s, then hold the final report screenshot for 3s.
make_video_segment "00:04:20" 12 1 "$WORKDIR/segment-08-report-video.mp4"

make_image_segment "$SHOT_REPORT" 3 "$WORKDIR/segment-09-report-hold.mp4"
make_image_segment "$ENDING_IMAGE" 3 "$WORKDIR/segment-10-ending.mp4"

for segment in "$WORKDIR"/segment-*.mp4; do
  printf "file '%s'\n" "$(ffmpeg_escape_path "$PWD/$segment")" >> "$CONCAT_FILE"
done

ffmpeg -hide_banner -y \
  -f concat -safe 0 -i "$CONCAT_FILE" \
  -c copy "$WORKDIR/merged.mp4"

if ffmpeg -hide_banner -y \
  -i "$WORKDIR/merged.mp4" \
  -vf "subtitles=$SUBTITLES" \
  -an -c:v libx264 -preset medium -crf 18 -movflags +faststart \
  "$OUTPUT"; then
  FINAL_OUTPUT="$OUTPUT"
else
  echo "Subtitle burn-in failed; exporting no-subtitle fallback: $OUTPUT_NOSUB" >&2
  ffmpeg -hide_banner -y \
    -i "$WORKDIR/merged.mp4" \
    -an -c:v libx264 -preset medium -crf 18 -movflags +faststart \
    "$OUTPUT_NOSUB"
  FINAL_OUTPUT="$OUTPUT_NOSUB"
fi

ffprobe -v error \
  -show_entries format=duration,size \
  -show_entries stream=codec_name,width,height \
  -of default=noprint_wrappers=1 \
  "$FINAL_OUTPUT"
