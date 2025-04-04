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
    echo -e "Usage: $0 [file1.csv file2.csv ...]"
    echo -e "If no files are specified, all CSV files in the ./csv directory will be used."
    exit 1
}

# Function to combine CSV files
combine_csv_files() {
    echo -e "\nCombining CSV files..."
    
    # Ensure csv directory exists
    mkdir -p "$CSV_DIR"
    
    # Create/empty the combined CSV file
    > "$COMBINED_CSV"
    
    # Combine all CSV files provided as arguments
    for file in "$@"; do
        if [ ! -f "$file" ]; then
            echo -e "Warning: File not found: $file (skipping)"
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
        echo -e "Error: No valid data found in input files"
        exit 1
    fi
    
    # Check if the CSV has at least 2 columns
    if [ $(head -n 1 "$COMBINED_CSV" | awk -F, '{print NF}') -lt 2 ]; then
        echo -e "Error: CSV file must have at least 2 columns"
        exit 1
    fi
    
    echo -e "  Combined $(wc -l < "$COMBINED_CSV") text replacements from $# files"
}

# Function to convert CSV to plist
csv2plist() {
    echo -e "\nConverting CSV to plist format..."
    
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
        echo -e "Error: Generated plist is not valid"
        exit 1
    fi
    
    echo -e "  Successfully created plist file with $(grep -c "<dict>" "$OUTPUT_PLIST") text replacements"
}

# Function to import plist into macOS
import_plist() {
    echo -e "\nImporting plist into macOS..."
    import_success=false
    
    # Check if the plist file exists
    if [ ! -f "$OUTPUT_PLIST" ]; then
        echo -e "Error: Plist file not found: $OUTPUT_PLIST"
        return 1
    fi
    
    # Try different import methods
    if defaults import -g NSUserDictionaryReplacementItems "$OUTPUT_PLIST" 2>/dev/null; then
        echo -e "  Imported text replacements successfully"
        import_success=true
    elif sudo defaults import -g NSUserDictionaryReplacementItems "$OUTPUT_PLIST" 2>/dev/null; then
        echo -e "  Imported text replacements successfully using sudo"
        import_success=true
    else
        echo -e "  Error: Failed to import plist into macOS"
        return 1
    fi
    
    return 0
}

# Function to clean up temporary files
cleanup() {
    echo -e "\nCleaning up temporary files..."
    # We're keeping the final files, just removing the combined CSV
    rm -f "$COMBINED_CSV"
    # report_results $?
    echo -e "  done."
}

# function to report results
report_results() {
    echo -e "\n==============================="
    if [ $1 -eq 0 ]; then
        echo -e "Text Replacements imported successfully!"
    else
        echo -e "Text Replacements import failed! You will need to manually import the plist file."
    fi
    echo -e "==============================="
    echo -e "\nPlist file created: $OUTPUT_PLIST"
    echo -e "\nTo import manually:"
    echo -e "Drag and drop this file into System Settings > Keyboard > Text Replacements"
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
            echo -e "Error: No CSV files found in $CSV_DIR directory"
            show_usage
        fi
    fi
    
    # Combine input files
    combine_csv_files "${INPUT_FILES[@]}"
    
    # Convert CSV to plist
    csv2plist

    # Try to import plist text replacements into macOS
    # import_plist
    # import_result=$?
    # echo -e "  $import_result failures from import."

    # Report results
    report_results $?

    # Cleanup temporary files
    cleanup
    echo -e "  done."
}

# Run the main function
main "$@"