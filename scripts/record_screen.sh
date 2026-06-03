#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <output-file> [seconds]"
  echo "Example: $0 assets/demos/autoflow-demo.mov 60"
  exit 1
fi

output_file="$1"
duration="${2:-60}"
output_dir="$(dirname "$output_file")"

if ! [[ "$duration" =~ ^[0-9]+$ ]] || [[ "$duration" -le 0 ]]; then
  echo "Error: recording seconds must be a positive integer."
  exit 1
fi

mkdir -p "$output_dir"

cat <<'EOF'
Before recording, please check and hide:
- API keys, tokens, and .env files
- WeChat, email, and private chat windows
- Account names, phone numbers, addresses, and private browser pages
- Desktop files or notifications containing sensitive information

This script uses macOS screencapture and does not upload any files.
System audio is not recorded by screencapture.
EOF

read -r -p "Press Enter to start the 3-second countdown, or Ctrl+C to cancel..."

echo "Recording starts in:"
for second in 3 2 1; do
  echo "$second..."
  sleep 1
done

echo "Recording for ${duration} seconds..."
screencapture -v -T "$duration" "$output_file"

echo "Recording saved to: $output_file"
