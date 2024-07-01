#!/bin/bash

# Set the directory containing your Jekyll posts
POSTS_DIR="../_posts"

# Function to remove BOM from a file
remove_bom() {
  local file="$1"
  if [ "$(head -c 3 "$file")" = $'\xef\xbb\xbf' ]; then
    tail -c +4 "$file" > "$file.nobom" && mv "$file.nobom" "$file"
    echo "Removed BOM from $file"
  fi
}

# Loop through each markdown file in the posts directory
for file in "$POSTS_DIR"/*.md; do
  echo "Processing file: $file"
  
  # Convert the file from ANSI to UTF-8 encoding
  iconv -f WINDOWS-1252 -t UTF-8 "$file" -o "${file}.utf8"
  
  # Remove BOM if present
  remove_bom "${file}.utf8"
  
  # Overwrite the original file with the converted content
  mv "${file}.utf8" "$file"
  echo "Converted $file to UTF-8"
done

echo "All files have been converted to UTF-8."

# Verify encoding of all files in the _posts directory
for file in "$POSTS_DIR"/*.md; do
  encoding=$(file -bi "$file")
  echo "$file: $encoding"
done
