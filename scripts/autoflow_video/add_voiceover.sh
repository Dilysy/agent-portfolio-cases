#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

INPUT_VIDEO="assets/demos/autoflow-agent/autoflow-agent-demo.mp4"
INPUT_AUDIO="assets/demos/autoflow-agent/autoflow-voiceover.m4a"
OUTPUT_VIDEO="assets/demos/autoflow-agent/autoflow-agent-demo-voiceover.mp4"

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is required but was not found in PATH." >&2
  exit 1
fi

if ! command -v ffprobe >/dev/null 2>&1; then
  echo "ffprobe is required but was not found in PATH." >&2
  exit 1
fi

for file in "$INPUT_VIDEO" "$INPUT_AUDIO"; do
  if [[ ! -f "$file" ]]; then
    echo "Required file not found: $file" >&2
    exit 1
  fi
done

mkdir -p "$(dirname "$OUTPUT_VIDEO")"

VIDEO_DURATION="$(ffprobe -hide_banner -loglevel error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT_VIDEO")"

ffmpeg -hide_banner -y \
  -i "$INPUT_VIDEO" \
  -i "$INPUT_AUDIO" \
  -filter_complex "[1:a]apad,atrim=0:${VIDEO_DURATION},asetpts=PTS-STARTPTS[aout]" \
  -map 0:v:0 -map "[aout]" \
  -c:v copy \
  -c:a aac -b:a 160k \
  -movflags +faststart \
  -t "$VIDEO_DURATION" \
  "$OUTPUT_VIDEO"

echo "Generated: $OUTPUT_VIDEO"

ffprobe -hide_banner -loglevel error \
  -show_entries format=duration,size \
  -show_entries stream=index,codec_type,codec_name,width,height \
  -of default=noprint_wrappers=1 "$OUTPUT_VIDEO"
