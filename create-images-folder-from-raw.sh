#!/bin/bash

START_TIME=$SECONDS

SOURCE_DIR="assets/raw_images"
TARGET_DIR="assets/images"

echo "Size of $SOURCE_DIR before processing:"
du -sh "$SOURCE_DIR"

mkdir -p "$TARGET_DIR"

# Count total number of files excluding .DS_Store
total_files=$(find "$SOURCE_DIR" -type f | grep -v '.DS_Store' | wc -l)
echo "Total files to process: $total_files"

processed_files=0

# Find all files in the source directory, replicate the structure in the target directory, and process images
find "$SOURCE_DIR" -type f | while read -r file; do
  # Skip .DS_Store files
  if [[ "$(basename "$file")" == ".DS_Store" ]]; then
    continue
  fi

  # Generate the target file path by replacing the source directory with the target directory in the file path
  # Ensure the file has a .png extension for output
  target_file="${file/$SOURCE_DIR/$TARGET_DIR}"
  target_file="${target_file%.*}.png"
  mkdir -p "$(dirname "$target_file")"

  # Get the width of the image
  width=$(identify -format "%w" "$file")

  # Calculate half of the width
  new_width=$((width / 2))

  # Resize the image to half of its original width while maintaining aspect ratio
  convert "$file" -resize "${new_width}x" "$target_file"

  # Update and display progress
  ((processed_files++))
  echo "Processed $processed_files of $total_files files: $file"
done

echo "Processing completed."

echo "Size of $SOURCE_DIR before processing:"
du -sh "$SOURCE_DIR"

echo "Size of $TARGET_DIR after processing:"
du -sh "$TARGET_DIR"

END_TIME=$SECONDS
DURATION=$((END_TIME - START_TIME))

echo "Time taken to convert images: $DURATION seconds."
