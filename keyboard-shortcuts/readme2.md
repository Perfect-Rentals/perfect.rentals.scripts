# Prefect Rentals | Keyboard Shortcuts (MacOS)

A collection of sales and marketing keyboard shortcuts for text replacement for MacOS. These shortcuts can be dragged and dropped into your Mac computer instantly providing access to 44+ text replacement shortcuts. Save yourself a ton of time to avoid repetitive work. Packed with these shortcuts is a powerful conversion script, allowing you to create and format your own keyboard shortcuts for easy import into MacOS.

### Key Benefits

- **Save Time**: The prepared content allows you to import [44+ prepared sales lead keyboard shortcuts](./text-replacements.md)
- **Customize**: Modify existing prepared content or create your own preferred shortcuts and responses
- **Organize**: Keep different types of responses (objection handlers, closing questions, etc.) in separate files
- **Portable**: Easily share your shortcuts with team members
- **Free:** Prepared content and conversion scripts are free.

## Overview

When talking to seller leads, realtors, or any sales and marketing audience, you will frequently ask the same questions or write the same content to your audience. For example, when you are talking to a seller lead, you may ask the same questions over and over again:

- What is the property address?
- Why are you selling?
- When do you want to sell?
- and so on...

This interaction with the person, while a very important sales or marketing activity, quickly becomes very time consuming and tedious. This script installs a collection of keyboard shortcuts to reduce the repetitive task of typing each full question or rebuttal response to each seller. Instead, you can type the desired shortcut and your Mac computer will replace the shortcut text with the replacement text.

For example, for your opening script questions with a seller lead:

| Shortcut     | Question / Text Replacement                                                                   |
| ------------ | --------------------------------------------------------------------------------------------- |
| `osq1`       | Hi [name]. I saw your comment in the [group] Facebook group. Do you have a property for sale? |
| `osq1-phone` | What's your phone number?                                                                     |
| `osq2`       | Why are you selling?                                                                          |
| `osq3`       | When do you want to sell?                                                                     |

The Text Replacement Shortcut Manager helps you:

1. Organize your text replacements in easy-to-edit CSV files
2. Combine multiple CSV files into a single collection
3. Convert these to the proper plist format for macOS import
4. Import them into your System Settings
5. Speed up your sales lead generation process significantly

## Project Structure

```
keyboard-shortcuts/
├── csv/                      # Directory for CSV files
│   ├── cfp_closing_script_questions.csv
│   ├── cfp_opening_script_questions.csv
│   ├── mac_default.csv
│   ├── rei_marketing_outreach.csv
│   ├── seller_concern_handlers.csv
│   ├── seller_follow_up_handlers.csv
│   ├── seller_objection_handlers.csv
│   └── seller_request_handlers.csv
├── plist/                    # Directory for generated plist files
│   └── combined.plist        # The combined plist output file
├── kbd-shortcuts-mac.sh      # Main script for conversion
└── text-replacements.md      # Markdown reference of all shortcuts
```

## Importing Prepared Text Replacements into MacOS

The project is packaged with 44+ text replacement keyboard shortcuts that are ready to import.

### Import Method 1: Drag and Drop (Recommended)

1. Open System Settings
2. Navigate to Keyboard → Text Replacements
3. Drag and drop the `plist/combined.plist` file into the text replacements window
4. Wait for the import to complete (this may take a few moments)

> It is recommended to reboot your computer after running this command to register the new shortcuts.

### Import Method 2: Command Line Import (Experimental)

Alternatively, you can try import via the command line. Open a Terminal (Launchpad > Terminal)

```bash
cd path/to/project
sudo defaults import -g NSUserDictionaryReplacementItems ./plist/combined.plist
```

> Note: You may need to use `sudo` if you encounter permission issues.

You will need to reboot after running this command to register the new shortcuts. It works maybe 50% of the time.

<h3 id="customization">Customization</h3>

You can customize the text replacement keyboard shortcuts with your own content. Add, modify, or remove shortcuts by editing the CSV files in the `csv/` directory. The script will combine all CSV files into a single plist file for import. You can add more CSV files with your own shortcuts, or modify the existing ones.

Follow these instructions to create, convert, and import your own text replacement shortcuts.

<h3 id="csv-format">Understanding the CSV Format</h3>

CSV, or comma separated values, is a simple file format used to store tabular data. In this case, we will use CSV files to define keyboard shortcuts and their corresponding text replacements. Excel or Google Sheets can be used to create and edit CSV files, but you can also use a simple text editor.

<h3 id="csv-structure">CSV Structure</h3>

Each CSV file should have two columns without column headers. Content should be wrapped in double quotes and separated by a comma. The first column is the shortcut, and the second column is the replacement text.

Each line should be formatted as follows:

```csv
"shortcut","replacement text"
```

Example:

```csv
"osq1","Hi [name]. I saw your comment on the [group] Facebook group."
"why-tax","We ask because if there are any back taxes or liens..."
```

<h3 id="add">Adding Custom Keyboard Shortcuts</h3>
<h3 id="mod">Modifying Keyboard Shortcuts</h3>
<h3 id="del">Deleting Keyboard Shortcuts</h3>

<h3 id="convert">Converting CSV Keyboard Shortcuts to PLIST Format</h3>

MacOS uses a specific format for text replacements, which is a plist file. The script provided in this project will convert your CSV files into the correct plist format for you.

To convert your CSV files to plist format, follow these steps:

1. Create your CSV file(s) (or modify an existing CSV file)
2. Save in the `csv/` directory
3. Place your CSV files in the `csv/` directory
4. Run the script:

```bash
# navigate to the keybaord-shortcuts folder
cd path/to/project/root
cd keyboard-shortcuts

# make the script executable
chmod +x ./kbd-shortcuts-mac.sh

# run the script
./kbd-shortcuts-mac.sh
```

The script will:

- Combine all CSV files in the `csv/` directory
- Convert them to a plist file at `plist/combined.plist`
- Show instructions for importing

### Advanced Usage

You can specify specific CSV files to process:

```bash
./kbd-shortcuts-mac.sh ./csv/mac_default.csv ./csv/seller_objection_handlers.csv
```

## Troubleshooting

**Shortcuts not appearing after import:**

- Restart your applications (or entire system) to ensure they recognize the new replacements
- Check if you have too many replacements (macOS may have limits)

**Import errors:**

- Ensure the plist file is valid by running: `plutil -lint ./plist/combined.plist`
- Try the drag-and-drop method if command line fails

## Reference

See [Text Replacement Reference](./text-replacements.md) for a comprehensive list of all the prepared keyboard shortcuts.

The included shortcut categories include:

- Marketing & Outreach Scripts (for generating leads)
- CFP Opening Script Questions (initial contact with seller leads)
- CFP Terms Scripts (explaining creative financing options)
- "Why" Responses (Seller Objection Handlers for common questions)
- CFP Closing Script Questions (finalizing deals effectively)
- "When" Responses (Seller Concern Handlers for addressing risks)
- Definitions and Other Responses (explaining key terms)
- Seller Follow-Up Responses (maintaining engagement)

The prepared content includes 44+ text replacement shortcuts specifically designed for real estate investors and agents working with seller leads. Each category contains carefully crafted responses to help you communicate professionally and efficiently.

## Notes

- Some text replacements include placeholders like `[name]` or `[price]` that you'll need to customize after expansion
- All shortcuts are usable across macOS, iOS, and iPadOS thanks to iCloud sync (enable in System Settings → iCloud → iCloud Drive → System Settings)
- Use meaningful prefixes (like "why-" or "csq") to organize shortcuts by category
- The script is designed to be easily extensible - simply add new CSV files with your own shortcuts
- These shortcuts work in any app where you can type text: Messages, Mail, Facebook Messenger, Notes, etc.

## For Teams

If you're working with a team:

1. Create a shared folder for your CSV files
2. Each team member can customize their own shortcuts or use the team standards
3. Run the script to generate and import the plist file
4. Everyone can work from the same script templates while still customizing as needed

This ensures consistent communication with leads while still allowing personal adaptations.
