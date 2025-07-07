#!/bin/bash

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

echo "📄 Checking: $FILE"

# Check file type
file "$FILE"

# Check PNG magic number
echo -n "🔍 Magic number: "
xxd -p -l 8 "$FILE" | tr -d '\n'
echo

# Check file size
SIZE=$(stat -f%z "$FILE" 2>/dev/null || stat -c%s "$FILE")
echo "📦 File size: $SIZE bytes"

# Check for readable image using ImageMagick (if available)
if command -v identify &>/dev/null; then
  identify "$FILE" && echo "✅ ImageMagick can read it." || echo "❌ ImageMagick cannot read it."
else
  echo "ℹ️ Install ImageMagick to check image decoding: brew install imagemagick"
fi

