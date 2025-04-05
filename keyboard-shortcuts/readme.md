<h1 id="top">Perfect Rentals | Keyboard Shortcuts (MacOS)</h1>

A collection of sales and marketing keyboard shortcuts for real estate investors. Tired of typing the same messages into Facebook groups, Messenger, or other social media and marketing sites? Simple type the appropriate shortcut and your MacOS device will replace it with the text replacement value.

But wait, there's more! This project also includes a script to convert your own CSV files into the proper plist format for MacOS import. You can create your own keyboard shortcuts and text replacements, or modify existing ones.

This project is designed to help you save time and effort when communicating with leads, clients, or team members. By using keyboard shortcuts, you can streamline your workflow and focus on what really matters: finding sellers, closing deals, and building relationships.

For Apple documentation, see [Text Replacement](https://support.apple.com/guide/mac-help/replace-text-punctuation-documents-mac-mh35735/mac).

## **Quick start**

- Download the [MacOS shortcuts file](./plist/combined.plist) to your Mac computer
- Drag and drop the [MacOS shortcuts file](./plist/combined.plist) into your Settings → Keyboard → Text Replacement.

Instantly you have access to [44+ prepared text replacement keyboard shortcuts](./text-replacements.md).

<h2 id="benefits">Key Benefits</h2>

- **Saves Time**: Use the prepared keyboard shortcuts instead of making your own
- **Easy to Install**: Drag-and-drop import into MacOS → Settings → Keyboard → Text Replacement
- **Easy to Use**: Type the shortcut, press `<ENTER>` KEY, and the replacement text appears. Modify as needed.
- **Customizable**: Modify existing keyboard shortcuts or create your own preferred shortcuts and responses
- **Organized**: Keep different types of responses (objection handlers, closing questions, etc.) in separate files
- **Portable**: Easily share shortcuts files with team members
- **Free:** All prepared content and conversion scripts are free to use and modify
- **Open Source**: The project is open source. Modify and improve the code as you see fit. Contributions are welcome!
-  **Friendly**: The shortcuts work across macOS, iOS, and iPadOS thanks to iCloud sync

<h2 id="overview">Overview</h2>

When talking to seller leads, realtors, or any sales and marketing audience, you will frequently ask the same questions or write the same content into social media sites, Facebook Messenger, text, and email. For example, when you are talking to a many seller leads in a day, you may ask the same questions over and over again. This interaction with each seller, while a very important sales or marketing activity, quickly becomes very time consuming and often tedious.

- What is the property address?
- Why are you selling?
- When do you want to sell?
- and so on...

**Keyboard Shortcuts**. This collection of keyboard shortcuts reduces the repetitive task of typing each full question or rebuttal response to each seller. Instead, you can type the appropriate shortcut and your computer will replace the shortcut with the replacement text.

For example, for your opening script questions with a seller lead:

| Shortcut | Question / Text Replacement                                                                   |
| -------- | --------------------------------------------------------------------------------------------- |
| `osq1`   | Hi [name]. I saw your comment in the [group] Facebook group. Do you have a property for sale? |
| `osq2`   | Why are you selling?                                                                          |
| `osq3`   | When do you want to sell?                                                                     |

See [Importing Prepared Text Replacements into MacOS](#import) for instructions on how to import the prepared keyboard shortcuts into your Mac computer.

**Keyboard Shortcut Converter**. This repo includes a bash script to convert your own CSV files into the proper plist format for MacOS import. You can create your own keyboard shortcuts and text replacements, or modify existing ones.

1. Organize your text replacements in easy-to-edit CSV files (Excel or Google Sheets)
2. Combine multiple CSV files into a single collection of keyboard shortcuts
3. Convert CSV shortcuts to the MacOS plist format for easy import
4. Import them into your MacOS System Settings

See [Customization](#customization) for instructions.

<h2 id="import">Importing Prepared Text Replacements into MacOS</h2>

The project is packaged with 44+ text replacement keyboard shortcuts that are ready to import.

1. Download the [./plist/combined.plist](./plist/combined.plist) to your Mac computer
2. Open  → System Settings → Keyboard → Text Replacement. You existing text replacements will be listed.
3. Drag and drop the `combined.plist` file into the text replacements window.
4. Wait for the import to complete (this may take a few moments)
5. Start typing your keyboard shortcuts in any app that supports text replacement (like Messages, Mail, Facebook Messenger, etc.)

> It is recommended to reboot your computer after running this command to register the new shortcuts.

<h2 id="customization">Customization</h2>

Included is a bash script for MacOS to customize the text replacement keyboard shortcuts as needed. You can add, modify, or remove any shortcuts by adding or editing the CSV files in the `csv/` directory. The script works by combining all CSV files into a single plist file for import. You can add more CSV files with your own shortcuts, or modify the existing ones, or delete the ones you do not want.

<h3 id="format">About CSV Format</h3>

CSV, or comma separated values, is a simple file format used to easily store and share tabular data. In this case, we will use CSV files to define keyboard shortcuts and their corresponding text replacements. Open any CSV file in Excel or Google Sheets to create and edit the CSV file. You can also use a simple text editor by entering the keyboard shortcuts in the [CSV Structure](#structure).

<h3 id="structure">CSV Structure</h3>

The structure of the CSV file used for conversion is important. Each CSV (Excel, Google Sheets) file should have two columns without column headers. Content should be wrapped in double quotes and separated by a comma.

- The first column is the shortcut value
- The second column is the replacement text value

Each line should be formatted as follows:

```csv
"shortcut","replacement text"
```

Example:

```csv
"hw","Hello World!"
"osq1","Hi [name]. I saw your comment on the [group] Facebook group."
```

<h3 id="add-csv">Adding Custom Keyboard Shortcuts</h3>
To add your own keyboard shortcuts, create a new CSV file in the `csv/` directory. You can name the file anything you like, but it is recommended to use a descriptive name that reflects the content of the shortcuts.
For example, you could create a file called `my_custom_shortcuts.csv` and add your own shortcuts in the same format as the prepared shortcuts.

```csv
"hw","Hello World!"
```

Follow the [converting CSV Keyboard Shortcuts to PLIST Format](#convert) instructions to convert your CSV files into the proper plist format for MacOS import.

<h3 id="mod-csv">Modifying Keyboard Shortcuts</h3>

To modify existing keyboard shortcuts, open the CSV file in the `csv/` directory that contains the shortcut you want to change. You can use Excel, Google Sheets, or a simple text editor. Find the line with the shortcut you want to modify and change the replacement text value.
For example, if you want to change the replacement text for the `osq1` shortcut, you would find the line that looks like this:

```csv
"osq1","Hi [name]. I saw your comment on the [group] Facebook group."
```

And change it to:

```csv
"osq1","Hi [name]. I saw your comment on the [group] Facebook group. I would love to help you with your property."
```

After making your changes, save the CSV file and follow the [converting CSV Keyboard Shortcuts to PLIST Format](#convert) instructions to convert your CSV files into the proper plist format for MacOS import.

<h3 id="del-csv">Deleting Keyboard Shortcuts</h3>

To delete keyboard shortcuts, open the CSV file in the `csv/` directory that contains the shortcut you want to delete. You can use Excel, Google Sheets, or a simple text editor. Find the line with the shortcut you want to delete and remove it from the file.
For example, if you want to delete the `osq1` shortcut, you would find the line that looks like this:

```csv
"osq1","Hi [name]. I saw your comment on the [group] Facebook group."
```

And remove it from the file. After making your changes, save the CSV file and follow the [converting CSV Keyboard Shortcuts to PLIST Format](#convert) instructions to convert your CSV files into the proper plist format for MacOS import.

> Note: Deleting the shortcut in the CSV file does not remove it your Mac computer. See [Deleting Keyboard Shortcuts From Your Computer](#del-mac) for instructions on how to remove the keyboard shortcut from your Mac computer.

<h3 id="convert">Converting CSV Keyboard Shortcuts to PLIST Format</h3>

MacOS uses a specific PLIST format for importing and exporting text replacements. The bash script provided in this project will convert your CSV files into the correct plist format for you.

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

<h2 id="Advanced Usage">Advanced Usage</h2>

You can make and specify specific CSV files to process. In bash, you can specify the CSV files to process by passing them as arguments to the script. For example, if you want to combine the `mac_default.csv` and `my-new-kbd-shortcuts.csv` files, you would run the script like this:

```bash
./kbd-shortcuts-mac.sh ./csv/mac_default.csv ./csv/my-new-kbd-shortcuts.csv
```

<h3 id="del-mac">Deleting Keyboard Shortcuts From Your Computer</h3>

To delete keyboard shortcuts from your Mac computer, follow these steps:

1. Open  → System Settings → Keyboard → Text Replacement
2. Find the keyboard shortcut you want to delete in the list of text replacements
3. Select the keyboard shortcut and press the minus (-) button to delete it
4. If you want to delete all keyboard shortcuts at once, hold the `option` key and press the minus (-) button
5. Confirm the deletion when prompted

> Note: You may need to restart your applications (or entire computer) to recognize the new replacements (best solution).

<h2 id="Troubleshooting">Troubleshooting</h2>

### Shortcuts not appearing after import

After dragging and dropping the [combined.plist](./plist/combined.plist) file into  → System Settings → Keyboard → Text Replacement you do not see the shortcuts

1. Restart your applications (or entire computer) to ensure they recognize the new replacements (best solution).
1. Check if you have too many replacements (macOS may have limits)

### Import errors

After dragging and dropping the [combined.plist](./plist/combined.plist) file into  → System Settings → Keyboard → Text Replacement you see nothing has changed or you receive an error message.

1. Ensure the plist file is valid by running the bash terminal command `plutil -lint ./plist/combined.plist`
2. Reboot and try the drag-and-drop method again

### Duplicate Keyboard Shortcuts Exist

After dragging and dropping the [combined.plist](./plist/combined.plist) file into  → System Settings → Keyboard → Text Replacement you see duplicate keyboard shortcuts.

1. If you drag and drop the same shortcut value twice, it will appear twice.

See [Deleting Keyboard Shortcuts From Your Computer](#del-mac) for instructions on how to remove the keyboard shortcut from your Mac computer.

<h2 id="Reference">Reference</h2>

See [Text Replacement Reference](./text-replacements.md) for a comprehensive list of all the prepared keyboard shortcuts.

The included shortcut categories include:

- CFP Opening Script Questions (initial contact with seller leads)
- CFP Terms Scripts (explaining creative financing options)
- CFP Closing Script Questions (finalizing deals effectively)
- Marketing & Outreach Scripts (for generating leads)
- "Why" Responses (Seller Objection Handlers for common questions)
- "When" Responses (Seller Concern Handlers for addressing risks)
- Definitions and Other Responses (explaining key terms)
- Seller Follow-Up Responses (maintaining engagement)

The prepared content includes text replacement shortcuts specifically designed for real estate investors and agents working with seller leads. Each category contains carefully crafted responses to help you communicate professionally and efficiently.

<h2 id="Notes">Notes</h2>

- Some text replacements include placeholders like `[name]` or `[price]` that you'll need to customize after expansion
- All shortcuts are usable across macOS, iOS, and iPadOS thanks to iCloud sync (enable in System Settings → iCloud → iCloud Drive → System Settings)
- Use meaningful prefixes (like "why-" or "csq") to organize shortcuts by category
- The script is designed to be easily extensible - simply add new CSV files with your own shortcuts
- These shortcuts work in any app where you can type text: Messages, Mail, Facebook Messenger, **Notes**, etc.

<h2 id="For Teams">For Teams</h2>

If you're working with a teams or VAs:

1. Create a shared folder for your CSV files
2. Each team member can customize their own shortcuts or use the team standards
3. Run the script to generate and import the plist file
4. Everyone can work from the same script templates while still customizing as needed

This ensures consistent communication with leads while still allowing personal adaptations.
