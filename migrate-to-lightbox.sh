#!/bin/bash

echo "🔍 Searching and replacing Magnific Popup classes with GLightbox..."

# Find all HTML files
find . -type f -name "*.html" | while read -r file; do
  echo "📄 Processing $file..."

  # Replace 'popup-image' with 'glightbox' in class attributes
  sed -i '' 's/class="\([^"]*\)popup-image\([^"]*\)"/class="\1glightbox\2"/g' "$file"

  # Replace 'popup-gallery' with 'glightbox' and add data-gallery attribute
  sed -i '' 's/class="\([^"]*\)popup-gallery\([^"]*\)"/class="\1glightbox\2" data-gallery="gallery1"/g' "$file"

  # Replace 'popup-youtube' with 'glightbox'
  sed -i '' 's/class="\([^"]*\)popup-youtube\([^"]*\)"/class="\1glightbox\2"/g' "$file"

  echo "✅ Updated: $file"
done

echo "🎉 Migration complete! Review your files for accuracy."

