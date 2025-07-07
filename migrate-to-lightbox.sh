#!/bin/bash

SEARCH_DIR="${1:-.}"
EXTENSIONS=("html" "md" "liquid")

# Inject these asset paths instead of CDN
GLIGHTBOX_CSS='<link rel="stylesheet" href="/assets/css/glightbox.min.css">'
GLIGHTBOX_JS='<script src="/assets/js/scripts.min.js"></script>'

# Inject assets if not already present
inject_assets() {
    local file="$1"
    local modified=false

    if ! grep -q 'assets/css/glightbox.min.css' "$file"; then
        sed -i '' '/<head[^>]*>/a\
'"$GLIGHTBOX_CSS"'
' "$file"
        modified=true
    fi

    if ! grep -q 'assets/js/scripts.min.js' "$file"; then
        sed -i '' '/<\/body>/i\
'"$GLIGHTBOX_JS"'
' "$file"
        modified=true
    fi

    if $modified; then
        echo "✨ Injected GLightbox local assets into: $file"
    fi
}

# Perform migration on one file
migrate_file() {
    local file="$1"
    local modified=false

    cp "$file" "$file.bak"

    # Replace popup-* class with glightbox
    sed -i '' -E 's/class="([^"]*)popup-[^"]*([^"]*)"/class="\1glightbox\2"/g' "$file" && modified=true

    # Replace .magnificPopup() with GLightbox
    sed -i '' -E 's/\$\(([^)]*)\)\.magnificPopup\([^)]*\);/const lightbox = GLightbox({selector: \1});/g' "$file" && modified=true

    # Replace known old assets if present
    sed -i '' \
        -e 's/magnific-popup\.css/assets\/css\/glightbox.min.css/g' \
        -e 's/jquery\.magnific-popup\.min\.js/assets\/js\/scripts.min.js/g' \
        "$file" && modified=true

    if $modified; then
        echo "✅ Migrated: $file"
        inject_assets "$file"
    else
        rm "$file.bak"
    fi
}

export -f migrate_file
export -f inject_assets
export GLIGHTBOX_CSS
export GLIGHTBOX_JS

# Find files to process
for ext in "${EXTENSIONS[@]}"; do
    find "$SEARCH_DIR" -type f -name "*.${ext}" -exec bash -c 'migrate_file "$0"' {} \;
done

