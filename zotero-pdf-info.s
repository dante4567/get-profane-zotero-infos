#!/bin/bash

# The directory to start searching from, replace with your actual directory
SEARCH_DIR="./Zotero"

# The output CSV file
OUTPUT_CSV="./zotero-pdf-info.csv"

# Print the CSV header
echo "FilePath,PageCount" > "$OUTPUT_CSV"

# Find all PDF files and get page counts
find "$SEARCH_DIR" -type f -name '*.pdf' | while read -r pdf_file; do
    page_count=$(pdfinfo "$pdf_file" | grep 'Pages' | awk '{print $2}')
    echo "\"$pdf_file\",$page_count" >> "$OUTPUT_CSV"
done

echo "CSV file created at $OUTPUT_CSV"
