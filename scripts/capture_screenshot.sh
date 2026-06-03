#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <output-file>"
  echo "Example: $0 assets/screenshots/autoflow-home.png"
  exit 1
fi

output_file="$1"
output_dir="$(dirname "$output_file")"

mkdir -p "$output_dir"

cat <<'EOF'
Before taking a screenshot, please check and hide:
- API keys, tokens, and .env files
- WeChat, email, and private chat windows
- Account names, phone numbers, addresses, and private browser pages
- Desktop files or notifications containing sensitive information

Interactive area screenshot will start after you press Enter.
EOF

read -r -p "Press Enter to continue, or Ctrl+C to cancel..."

screencapture -i "$output_file"

echo "Screenshot saved to: $output_file"
