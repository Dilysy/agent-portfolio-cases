#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

VOICEOVER_MD="assets/reports/autoflow-agent/autoflow-demo-voiceover.md"
VOICEOVER_TEXT="assets/demos/autoflow-agent/.autoflow-demo-build/autoflow-voiceover.txt"
AIFF_OUTPUT="assets/demos/autoflow-agent/autoflow-voiceover.aiff"
M4A_OUTPUT="assets/demos/autoflow-agent/autoflow-voiceover.m4a"
TMP_DIR="assets/demos/autoflow-agent/.autoflow-demo-build"

if ! command -v say >/dev/null 2>&1; then
  echo "macOS say command is required but was not found." >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is required to convert AIFF to M4A but was not found." >&2
  exit 1
fi

if [[ ! -f "$VOICEOVER_MD" ]]; then
  echo "Voiceover markdown not found: $VOICEOVER_MD" >&2
  exit 1
fi

mkdir -p "$TMP_DIR" "$(dirname "$AIFF_OUTPUT")"

python3 - <<'PY'
from pathlib import Path

src = Path("assets/reports/autoflow-agent/autoflow-demo-voiceover.md")
dst = Path("assets/demos/autoflow-agent/.autoflow-demo-build/autoflow-voiceover.txt")
lines = []
for line in src.read_text(encoding="utf-8").splitlines():
    line = line.strip()
    if not line or line.startswith("#"):
        continue
    lines.append(line)
dst.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY

say -v Tingting -r 190 -f "$VOICEOVER_TEXT" -o "$AIFF_OUTPUT"

ffmpeg -hide_banner -y \
  -i "$AIFF_OUTPUT" \
  -c:a aac -b:a 160k \
  "$M4A_OUTPUT"

echo "Generated: $AIFF_OUTPUT"
echo "Generated: $M4A_OUTPUT"

ffprobe -hide_banner -loglevel error \
  -show_entries format=duration,size \
  -of default=noprint_wrappers=1 "$M4A_OUTPUT"
