<h1 id="top">Perfect Rentals | Keyboard Shortcuts (Text Replacements)</h1>

This is a script to install a collection of `bash` scripts to manage (delete and enter) keyboard shortcuts (aka. Text Replacements) for your Mac computer for seller lead generation. The script will replace all your shortcuts with a [collection of real estate lead generation shortcuts](#reference).

<h2 id="why">Why do I want this?</h2>

When talking to seller leads, realtors, or any sales and marketing audience, you will frequently ask the same questions or write the same content to your audience. For example, when you are talking to a seller lead, you may ask the same questions over and over again:

- What is the property address?
- Why are you selling?
- When do you want to sell?
- and so on...

This interaction with the person, while a very important sales or marketing activity, quickly becomes very time consuming and tedious. This script installs a collection of keyboard shortcuts to reduce the repetitive task of typing each full question or rebuttal response to each seller. Instead, you can type the desired shortcut and your Mac computer will replace the shortcut text with the replacement text.

For example, for your opening script questions with a seller lead:

| Shortcut     | Question / Text Replacement                                                                     |
| ------------ | ----------------------------------------------------------------------------------------------- |
| `osq1`       | Hi [name].  I saw your comment in the [group] Facebook group.  Do you have a property for sale? |
| `osq1-phone` | What's your phone number?                                                                       |
| `osq2`       | Why are you selling?                                                                            |
| `osq3`       | When do you want to sell?                                                                       |

> **Note**: If you want a comprehensive list of shortcuts and text replacement strings, see [Text Replacement Reference](#reference).

Also, this script removes the tedious task of entering each text replacement shortcut manually. With this script, you can load all the keyboard shortcuts at once. See [Manual Setup (Tedious but Simple)](#manual) for the manual loading method.

<h2 id="install">Installing Keyboard Shortcuts by Script</h2>

> **Warning: To avoid duplication of shortcuts in your computer, this script will first backup and then overwrite any existing text replacements / keyboard shortcuts that currently exist. To be safe, consider [adding](#add) any custom keyboard shortcuts you already have added before continuing. It will back up the shortcuts on your local computer when it runs, so you can always [check your backup file](#backups) if you think you lost data.**

1. Download and save the [./kbd-shortcuts-mac.sh](./kbd-shortcuts-mac.sh) file to your Mac.

> **Note**: I'll assume you downloaded it to the `downloads` folder for the remainder of the instructions.
> **Note**: Windows is not supported at this time.

1. Open a new Mac terminal window (**Launchpad** → **Terminal**).
2. In the terminal app, type (or copy & paste) the commands below to find the file in your `downloads` folder. If you saved it elsewhere `cd` into that folder.

```bash
cd ~/downloads
ls kbd-shortcuts-mac.sh
```

You should see the `kbd-shortcuts-mac.sh` file listed.

4. Make the `kbd-shortcuts-mac.sh` file executable

```bash
chmod +x kbd-shortcuts.sh
```

<h3 id="run">Running the script</h3>

5. Run the script from the terminal

```bash
./kbd-shortcuts-mac.sh
```

> If you get a message that you do not have permissions try typing `sudo` first. You will likely be prompted for your computer's password to continue.

```bash
sudo ./kbd-shortcuts-mac.sh
```

6. The message below will appear in the terminal window. Confirm `Y` to continue or `N` to cancel.

   ```text
   Warning: This script will backup and replace all existing text replacement values on this computer.
   Do you want to continue? (Y/N):
   ```

   If you confirmed the script to run, the keyboard shortcuts will be installed. When it is done it will respond with `Done!`.

7. Close the terminal window.

<h2 id="test">Testing Keyboard Shortcuts</h2>

To test the script worked and the keyboard shortcuts were installed correctly, open any text editor, a blank Google doc, or your preferred messaging app and type the following:

`osq1`

You should see that the text was replaced with

> Hi [name].  I saw your comment in the [group] Facebook group.  Do you have a property for sale?

If the shortcut was replaced, then congratulations, it worked! You can now use [any of the keyboard shortcuts that were installed](#reference).

> **Note:** Any text in [brackets] should be manually replaced with the appropriate text before use.

<h2 id="mod">Modifying Custom Keyboard Shortcuts</h2>

If you want to modify any of the keyboard shortcuts, you can do so by editing the `kbd-shortcuts-mac.sh` file. Open the file in a text editor and look for the line that contains the shortcut you want to modify. For example:

```text
"osq1","Hi [name].  I saw your comment in the [group] Facebook group.  Do you have a property for sale?"
```

To change the shortcut, simply change the text in the first column. For example, if you want to change `osq1` to `q1`, you would change it to:

```text
"q1","Hi [name].  I saw your comment in the [group] Facebook group.  Do you have a property for sale?"
```

To change the text replacement, simply change the text in the second column. For example, if you want to change the text to `Hello [name]. I understand you have a property for sale? I'm interested!`, you would change it to:

```text
"q1","Hello [name]. I understand you have a property for sale? I'm interested!"
```

> **Note:** If you change the shortcut or the text replacement, you will need to run the script again to install the new shortcut. The script will overwrite any existing shortcuts with the new ones.

<h2 id="add">Adding Custom Keyboard Shortcuts</h2>

If you want to add your own custom keyboard shortcuts, you can do so by editing the `kbd-shortcuts-mac.sh` file. Open the file in a text editor. Find the the text `TRVDATA` that _exists on a single line_ (second instance). Add a new line before this word, then add your shortcut on the new line.

1. `CMD+F` to find the text `TRVDATA` (it'll be the second instance of this text)
2. Add a new line _before_ this text
3. Add your shortcut, one or more, each on the new line. For example:

```text
"greet-seller","Hello [name]! My name is [my-name]."
"get-phone","What's your phone number?"
"get-email","What's your email address?"
"get-addr","What's the property address?"
```

4. Save the file
5. [Run the script again](#run) to install the new shortcuts
6. [Test the new shortcuts](#test) by typing them in a text editor or messaging app.

<h2 id="manual">Manual Setup (Tedious but Simple)</h2>

Your Mac computer allows you to add your own text replacements (keyboard shortcuts). If you prefer to do this manually (i.e. not installing and running the script), follow this instructions.

1. Go to **System Settings** (or System Preferences) → **Keyboard** → **Text Replacements**
2. Click the "+" button to add a new replacement
3. In the "Replace" column, enter your shortcut (e.g., `q1`)
4. In the "With" column, paste the full text of the question/response
5. Repeat for each shortcut

> Note: Installing the script will overwrite any custom keyboard shortcuts added this way.
>
> - If you want to add your own custom shortcuts together with the script, see [Adding Custom Keyboard Shortcuts](#add).
> - If you want to modify any shortcut, see [Modifying Custom Keyboard Shortcuts](#mod).

<h2 id="backups">Backups</h2>

The script will create a backup of your existing keyboard shortcuts before overwriting them. The backup file will be saved in the `$HOME/backups/macos/keyboard-shortcuts-$timestamp.csv` file, where `$timestamp` is the date and time when you ran the script. You can check this file to see your previous shortcuts.

If a restore of one or more shortcuts is necessary, you can copy the shortcut line(s) desired from the backup file (using the [add](#add) instructions) and paste them into the `kbd-shortcuts-mac.sh` file. Then [run the script again](#run) to restore them into your computer.

<h2 id="reference">Text Replacement / Keyboard Shortcuts Reference</h2>

See [Text Replacements Reference](./text-replacements.md) for a comprehensive list of this version's text replacements / keyboard shortcuts by category. Each release of this script may add or remove shortcuts. The reference file will always be up to date with the latest version of the script.
