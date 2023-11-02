#!/bin/bash

# The directory to start searching from, replace with your actual directory
SEARCH_DIR="./Zotero"

# The output CSV file
OUTPUT_CSV="./zotero-pdf-info.csv"

# Print the CSV header
echo "FilePath,FileName,PageCount,Title,Author,Subject,Keywords,Creator,Producer,CreationDate,ModDate,Encrypted,PageSize" > "$OUTPUT_CSV"

# Initialize file counter
file_count=0

# Start timer
start_time=$(date +%s)

# Find all PDF files and get page counts
find "$SEARCH_DIR" -type f -name '*.pdf' | while read -r pdf_file; do
    file_count=$((file_count+1))
    file_path=$(dirname "$pdf_file")
    file_name=$(basename "$pdf_file")
    info=$(pdfinfo "$pdf_file")
    page_count=$(echo "$info" | grep 'Pages' | awk '{print $2}')
    title=$(echo "$info" | grep 'Title' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    author=$(echo "$info" | grep 'Author' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    subject=$(echo "$info" | grep 'Subject' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    keywords=$(echo "$info" | grep 'Keywords' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    creator=$(echo "$info" | grep 'Creator' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    producer=$(echo "$info" | grep 'Producer' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    creation_date=$(echo "$info" | grep 'CreationDate' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    mod_date=$(echo "$info" | grep 'ModDate' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    encrypted=$(echo "$info" | grep 'Encrypted' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    page_size=$(echo "$info" | grep 'Page size' | cut -d ':' -f2- | sed 's/^ *//;s/ *$//')
    
    # Output to CSV, escaping commas in metadata fields
    echo "\"$file_path\",\"$file_name\",$page_count,\"$title\",\"$author\",\"$subject\",\"$keywords\",\"$creator\",\"$producer\",\"$creation_date\",\"$mod_date\",\"$encrypted\",\"$page_size\"" >> "$OUTPUT_CSV"
done

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "CSV file created at $OUTPUT_CSV"
echo "Processed $file_count files in $duration seconds."
