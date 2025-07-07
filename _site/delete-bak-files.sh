#!/bin/bash

# Default to current directory if no argument provided
TARGET_DIR="${1:-.}"

echo "🔍 Searching for .bak files in: $TARGET_DIR"

# Find and delete all .bak files
find "$TARGET_DIR" -type f -name "*.bak" -print -delete

echo "✅ All .bak files deleted."

