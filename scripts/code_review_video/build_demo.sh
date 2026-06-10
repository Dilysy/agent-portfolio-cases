#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

VIDEO="assets/demos/code-review-agent/raw/code-review-agent-raw-demo.mov"
SUBTITLES="assets/reports/code-review-agent/demo-subtitles.srt"
ASS_SUBTITLES="assets/reports/code-review-agent/demo-subtitles.ass"
INDEX="assets/reports/code-review-agent/frame-preview-index.md"
OUT_DIR="assets/demos/code-review-agent"
OUT="$OUT_DIR/code-review-agent-demo.mp4"

WORK_DIR="assets/reports/code-review-agent/.video-build"
SEGMENTS_FILE="$WORK_DIR/segments.txt"
NOSUB_VIDEO="$WORK_DIR/code-review-agent-demo-nosub.mp4"
SUBTITLED_VIDEO="$WORK_DIR/code-review-agent-demo-subtitled.mp4"
SUBTITLE_LOG="$WORK_DIR/subtitle-error.log"

require_file() {
  if [[ ! -f "$1" ]]; then
    echo "Missing input file: $1" >&2
    exit 1
  fi
}

ffmpeg_escape_path() {
  printf '%s' "$1" | sed "s/'/'\\\\''/g"
}

supports_subtitle_filter() {
  "$1" -hide_banner -filters 2>/dev/null | grep -E " ass|subtitles" >/dev/null
}

subtitle_filter_name() {
  if "$FFMPEG" -hide_banner -filters 2>/dev/null | grep -E " ass" >/dev/null; then
    printf '%s\n' "ass"
  elif "$FFMPEG" -hide_banner -filters 2>/dev/null | grep -E "subtitles" >/dev/null; then
    printf '%s\n' "subtitles"
  else
    echo "未找到支持 ass/libass 的 ffmpeg。请执行 brew install ffmpeg 或 brew reinstall ffmpeg 后重试。" >&2
    exit 1
  fi
}

select_ffmpeg() {
  local candidate
  local path_ffmpeg=""

  if command -v ffmpeg >/dev/null 2>&1; then
    path_ffmpeg="$(command -v ffmpeg)"
  fi

  for candidate in \
    /usr/local/opt/ffmpeg-full/bin/ffmpeg \
    /opt/homebrew/opt/ffmpeg-full/bin/ffmpeg \
    /usr/local/bin/ffmpeg \
    /opt/homebrew/bin/ffmpeg \
    "$path_ffmpeg"; do
    if [[ -n "$candidate" && -x "$candidate" ]] && supports_subtitle_filter "$candidate"; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  echo "未找到支持 ass/libass 的 ffmpeg。请执行 brew install ffmpeg 或 brew reinstall ffmpeg 后重试。" >&2
  exit 1
}

select_ffprobe() {
  local ffmpeg_dir
  ffmpeg_dir="$(dirname "$FFMPEG")"

  if [[ -x "$ffmpeg_dir/ffprobe" ]]; then
    printf '%s\n' "$ffmpeg_dir/ffprobe"
  elif command -v ffprobe >/dev/null 2>&1; then
    command -v ffprobe
  else
    echo "未找到 ffprobe，无法输出视频元信息。请安装包含 ffprobe 的 ffmpeg。" >&2
    exit 1
  fi
}

write_ass_subtitles() {
  cat > "$ASS_SUBTITLES" <<'ASS'
[Script Info]
ScriptType: v4.00+
Collisions: Normal
PlayResX: 1920
PlayResY: 1080
Timer: 100.0000

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Default,PingFang SC,28,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2,0,2,80,80,45,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
Dialogue: 0,0:00:00.00,0:00:03.00,Default,,0,0,0,,代码审查 Agent
Dialogue: 0,0:00:03.00,0:00:14.00,Default,,0,0,0,,输入待审查代码
Dialogue: 0,0:00:14.00,0:00:28.00,Default,,0,0,0,,生成真实审查结果
Dialogue: 0,0:00:28.00,0:00:35.00,Default,,0,0,0,,输出结构化审查报告
Dialogue: 0,0:00:35.00,0:00:45.00,Default,,0,0,0,,标注问题清单与风险等级
Dialogue: 0,0:00:45.00,0:00:58.00,Default,,0,0,0,,生成修复建议并保留人工复核
ASS
}

require_file "$VIDEO"
require_file "$SUBTITLES"
require_file "$INDEX"

FFMPEG="$(select_ffmpeg)"
FFPROBE="$(select_ffprobe)"
SUBTITLE_FILTER="$(subtitle_filter_name)"
echo "Using ffmpeg: $FFMPEG"
echo "Using subtitle filter: $SUBTITLE_FILTER"

mkdir -p "$OUT_DIR" "$WORK_DIR"
rm -f "$WORK_DIR"/segment-*.mp4 "$SEGMENTS_FILE" "$NOSUB_VIDEO" "$SUBTITLED_VIDEO" "$SUBTITLE_LOG" "$OUT"
write_ass_subtitles

COMMON_SCALE="scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=black,setsar=1,fps=30,format=yuv420p"

make_video_segment() {
  local start="$1"
  local duration="$2"
  local speed="$3"
  local output="$4"

  "$FFMPEG" -y -hide_banner -loglevel error \
    -ss "$start" -t "$duration" -i "$VIDEO" \
    -vf "setpts=PTS/${speed},${COMMON_SCALE}" \
    -an \
    -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 -movflags +faststart \
    "$output"
}

# Target timeline, about 56 seconds total:
# 1. 00:00-00:04 at 1.35x => 3.0s, title / code sample
# 2. 00:00-00:15 at 1.35x => 11.1s, review target code
# 3. 00:20-00:35 at 1.15x => 13.0s, real Agent review output
# 4. 00:40-00:43 at 1.0x  => 3.0s, report preview transition
# 5. 00:50-01:00 at 1.0x  => 10.0s, issue list and risk levels
# 6. 01:00-01:15 at 1.15x => 13.0s, fix suggestions and human review
make_video_segment "00:00:00" 4 1.35 "$WORK_DIR/segment-01-title.mp4"
make_video_segment "00:00:00" 15 1.35 "$WORK_DIR/segment-02-code-sample.mp4"
make_video_segment "00:00:20" 15 1.15 "$WORK_DIR/segment-03-real-output.mp4"
make_video_segment "00:00:40" 3 1.0 "$WORK_DIR/segment-04-report-transition.mp4"
make_video_segment "00:00:50" 10 1.0 "$WORK_DIR/segment-05-risk-list.mp4"
make_video_segment "00:01:00" 15 1.15 "$WORK_DIR/segment-06-fix-review.mp4"

for segment in "$WORK_DIR"/segment-*.mp4; do
  printf "file '%s'\n" "$(ffmpeg_escape_path "$PWD/$segment")" >> "$SEGMENTS_FILE"
done

"$FFMPEG" -y -hide_banner -loglevel error \
  -f concat -safe 0 -i "$SEGMENTS_FILE" \
  -an \
  -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 -movflags +faststart \
  "$NOSUB_VIDEO"

ASS_ABS_PATH="$PWD/$ASS_SUBTITLES"
ASS_FILTER_PATH="$(ffmpeg_escape_path "$ASS_ABS_PATH")"

if "$FFMPEG" -y -hide_banner -loglevel error \
  -i "$NOSUB_VIDEO" \
  -vf "$SUBTITLE_FILTER='$ASS_FILTER_PATH'" \
  -an \
  -c:v libx264 -pix_fmt yuv420p -preset medium -crf 20 -movflags +faststart \
  "$SUBTITLED_VIDEO" 2>"$SUBTITLE_LOG"; then
  if [[ ! -s "$SUBTITLED_VIDEO" ]]; then
    rm -f "$SUBTITLED_VIDEO" "$OUT"
    echo "ASS subtitle burn-in finished but output file is empty; formal output was not created: $OUT" >&2
    exit 1
  fi
  mv "$SUBTITLED_VIDEO" "$OUT"
  echo "Created Chinese hard-subtitled demo: $OUT"
else
  status=$?
  rm -f "$SUBTITLED_VIDEO" "$OUT"
  echo "ASS subtitle burn-in failed; final demo must include Chinese hard subtitles." >&2
  echo "Formal output was not created: $OUT" >&2
  echo "ffmpeg exit code: $status" >&2
  if [[ -s "$SUBTITLE_LOG" ]]; then
    echo "ffmpeg error log:" >&2
    sed -n '1,80p' "$SUBTITLE_LOG" >&2
  fi
  exit "$status"
fi

"$FFPROBE" -v error \
  -show_entries format=duration,size \
  -show_entries stream=codec_name,width,height \
  -of default=noprint_wrappers=1 \
  "$OUT"
