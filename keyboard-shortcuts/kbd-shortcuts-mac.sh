#!/bin/bash

# Error handling
set -e
set -o pipefail

# Directory paths
CSV_DIR="./csv"
PLIST_DIR="./plist"
COMBINED_CSV="${CSV_DIR}/_combined.csv"
OUTPUT_PLIST="${PLIST_DIR}/combined.plist"

# Function to display usage information
show_usage() {
    echo "Usage: $0 [file1.csv file2.csv ...]"
    echo "If no files are specified, all CSV files in the ./csv directory will be used."
    exit 1
}

# Function to combine CSV files
combine_csv_files() {
    echo "Combining CSV files..."
    
    # Ensure csv directory exists
    mkdir -p "$CSV_DIR"
    
    # Create/empty the combined CSV file
    > "$COMBINED_CSV"
    
    # Combine all CSV files provided as arguments
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo "Warning: File not found: $file (skipping)"
            continue
        fi
        
        # Append file content (skip header if not first file)
        if [ -s "$COMBINED_CSV" ]; then
            tail -n +2 "$file" >> "$COMBINED_CSV"
        else
            cat "$file" > "$COMBINED_CSV"
        fi
    done
    
    # Validate combined CSV file
    if [ ! -s "$COMBINED_CSV" ]; then
        echo "Error: No valid data found in input files"
        exit 1
    fi
    
    # Check if the CSV has at least 2 columns
    if [ $(head -n 1 "$COMBINED_CSV" | awk -F, '{print NF}') -lt 2 ]; then
        echo "Error: CSV file must have at least 2 columns"
        exit 1
    fi
    
    echo "Combined $(wc -l < "$COMBINED_CSV") lines from $# files"
}

# Function to convert CSV to plist
csv2plist() {
    echo "Converting CSV to plist format..."
    
    # Ensure plist directory exists
    mkdir -p "$PLIST_DIR"
    
    # Create plist header
    {
        echo '<?xml version="1.0" encoding="UTF-8"?>'
        echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
        echo '<plist version="1.0">'
        echo '<array>'
    } > "$OUTPUT_PLIST"
    
    # Process each line of the CSV file
    awk -F, '{
        # Skip empty lines
        if (NF < 2) next;
        
        shortcut = $1;
        # Extract everything after the first comma as replacement text
        replacement = substr($0, index($0, ",") + 1);
        
        # Remove surrounding quotes if present
        gsub(/^"/, "", shortcut);
        gsub(/"$/, "", shortcut);
        gsub(/^"/, "", replacement);
        gsub(/"$/, "", replacement);
        
        # Replace escaped quotes with actual quotes
        gsub(/""/, "\"", shortcut);
        gsub(/""/, "\"", replacement);
        gsub(/\\\"/, "\"", shortcut);
        gsub(/\\\"/, "\"", replacement);
        
        # XML-escape special characters
        gsub(/&/, "\\&amp;", shortcut);
        gsub(/</, "\\&lt;", shortcut);
        gsub(/>/, "\\&gt;", shortcut);
        gsub(/&/, "\\&amp;", replacement);
        gsub(/</, "\\&lt;", replacement);
        gsub(/>/, "\\&gt;", replacement);
        
        print "    <dict>";
        print "      <key>phrase</key>";
        print "      <string>" replacement "</string>";
        print "      <key>shortcut</key>";
        print "      <string>" shortcut "</string>";
        print "    </dict>";
    }' "$COMBINED_CSV" >> "$OUTPUT_PLIST"
    
    # Close the plist
    {
        echo '  </array>'
        echo '</plist>'
    } >> "$OUTPUT_PLIST"
    
    # Validate the plist
    if ! plutil -lint "$OUTPUT_PLIST" > /dev/null 2>&1; then
        echo "Error: Generated plist is not valid"
        exit 1
    fi
    
    echo "Successfully created plist with $(grep -c "<dict>" "$OUTPUT_PLIST") entries"
}

# Function to clean up temporary files
cleanup() {
    echo "Cleaning up temporary files..."
    # We're keeping the final files, just removing the combined CSV
    rm -f "$COMBINED_CSV"
}

# Main function
main() {
    # Set up trap for cleanup on exit
    trap cleanup EXIT
    
    # Determine input files
    if [ $# -gt 0 ]; then
        # User specified files as arguments
        INPUT_FILES=("$@")
    else
        # Use all CSV files in the CSV directory
        INPUT_FILES=($(ls ${CSV_DIR}/*.csv 2>/dev/null))
        if [ ${#INPUT_FILES[@]} -eq 0 ]; then
            echo "Error: No CSV files found in $CSV_DIR directory"
            show_usage
        fi
    fi
    
    # Combine input files
    combine_csv_files "${INPUT_FILES[@]}"
    
    # Convert CSV to plist
    csv2plist
    
    echo "Plist file created: $OUTPUT_PLIST"
    echo ""
    echo "To import, either:"
    echo "1. Drag and drop this file into System Settings > Keyboard > Text Replacements"
    echo "2. Or use: defaults import -g NSUserDictionaryReplacementItems \"$OUTPUT_PLIST\""
}

# Run the main function
main "$@"