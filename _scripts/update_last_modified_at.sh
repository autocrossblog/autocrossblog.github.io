#!/bin/bash

# This script is used to update all your _posts last_modified_at attribute to the current date/time. 
# You typically want to do this when you update the structure on your site, not every time you create a new post
# To do this, you need to be in a prompt do the following to things
# Make the script executable: chmod +x ../_scripts/update_last_modified.sh.
# Run the script from the _scripts directory: ../_scripts/update_last_modified.sh.


# Set the directory containing your Jekyll posts
POSTS_DIR="../_posts"

# Set the new last modified date (current date and time in ISO 8601 format)
NEW_DATE=$(date -u +"%Y-%m-%dT%H:%M:%S+00:00")

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

  # Remove BOM if present
  remove_bom "$file"

  temp_file=$(mktemp)
  inside_front_matter=false
  last_modified_at_present=false
  last_modified_at_line="last_modified_at: '$NEW_DATE'"
  front_matter=()
  content=()

  while IFS= read -r line; do
    if [[ "$line" == "---" ]]; then
      if $inside_front_matter; then
        # Closing front matter
        inside_front_matter=false
        if ! $last_modified_at_present; then
          front_matter+=("$last_modified_at_line")
        fi
        front_matter+=("$line")
      else
        # Opening front matter
        inside_front_matter=true
        front_matter+=("$line")
      fi
    elif $inside_front_matter; then
      # Check for existing last_modified_at and remove it
      if [[ "$line" == "last_modified_at:"* ]]; then
        last_modified_at_present=true
        # Update the line to the new date
        front_matter+=("$last_modified_at_line")
      else
        front_matter+=("$line")
      fi
    else
      content+=("$line")
    fi
  done < "$file"

  # Ensure last_modified_at is in the front matter if it wasn't already present
  if ! $front_matter_complete; then
    if ! $last_modified_at_present; then
      front_matter+=("$last_modified_at_line")
    fi
    front_matter+=("---")
  fi

  # Write the front matter and content back to the file
  {
    printf "%s\n" "${front_matter[@]}"
    printf "%s\n" "${content[@]}"
  } > "$temp_file"

  # Overwrite the original file with the fixed content
  mv "$temp_file" "$file"
  echo "Updated last_modified_at date to '$NEW_DATE' in $file"
done

echo "All files have been updated."
