#!/bin/bash
# macOS Keyboard Shortcuts"
# This script backs up, deletes, and recreates text replacement values in macOS

# Help function
show_help() {
    echo "macOS Keyboard Shortcuts / Text Replacement Manager"
    echo "This script manages keyboard shortcut values (text replacements) in macOS."
    echo "To change the text replacements, edit the script and modify the values in the /tmp/trv_data.csv section."
    echo ""
    echo "Usage: ./text_replacement_manager.sh [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo ""
    echo "Description:"
    echo "  This script manages keyboard shortcut values (text replacements) in macOS."
    echo "  It will:"
    echo "    1. Back up existing keyboard shortcuts to ~/backups/macos/"
    echo "    2. Delete all existing keyboard shortcuts"
    echo "    3. Add new keyboard shortcuts defined in the script"
    echo ""
    echo "Note: This script requires administrator privileges to modify system settings."
    exit 0
}

# Process command line arguments. If user provides -h or --help, show help.
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

# Check if running on macOS. Should run on macOS only.
# Check if the script is running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script is intended to run on macOS only."
    exit 1
fi

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with root privileges. Please use 'sudo' to run this script."
    exit 1
fi

# Prompt for confirmation
echo "Warning: This script will backup and replace all existing text replacement values on this computer."
read -p "Do you want to continue? (Y/N): " confirmation

if [[ $confirmation != "Y" && $confirmation != "y" ]]; then
    echo "Operation cancelled."
    exit 0
fi

# Create backup directory if it doesn't exist
backup_dir="$HOME/backups/macos"
mkdir -p "$backup_dir"

# Generate timestamp for backup file
timestamp=$(date +"%Y%m%dT%H%M%S")
backup_file="$backup_dir/keyboard-shortcuts-$timestamp.csv"

echo "Creating backup of existing text replacements..."

# Export existing text replacements
osascript <<EOT > "$backup_file"
set csvOutput to "\"replace\",\"with\"\n"

tell application "System Events"
    tell application process "System Settings"
        set replacementsList to value of UI elements of table 1 of scroll area 1 of group 1 of window "Keyboard"
        
        repeat with i from 1 to count of replacementsList
            set currentRow to item i of replacementsList
            set replaceValue to value of text field 1 of currentRow
            set withValue to value of text field 2 of currentRow
            
            # Escape quotes in the values
            set replaceValue to my escapeQuotes(replaceValue)
            set withValue to my escapeQuotes(withValue)
            
            set csvOutput to csvOutput & "\"" & replaceValue & "\",\"" & withValue & "\"\n"
        end repeat
    end tell
end tell

on escapeQuotes(inputStr)
    set outputStr to ""
    repeat with i from 1 to length of inputStr
        set currentChar to character i of inputStr
        if currentChar is "\"" then
            set outputStr to outputStr & "\"\""
        else
            set outputStr to outputStr & currentChar
        end if
    end repeat
    return outputStr
end escapeQuotes

return csvOutput
EOT

# Count backup items
backup_count=$(grep -c "," "$backup_file")
backup_count=$((backup_count - 1)) # Subtract header

echo "Backed up $backup_count text replacements to $backup_file"

# Delete all existing text replacements
echo "Deleting existing text replacements..."
defaults delete -g NSUserDictionaryReplacementItems

# Define new text replacements
# *** REPLACE THESE VALUES WITH YOUR ACTUAL TEXT REPLACEMENTS ***
cat > /tmp/trv_data.csv << 'TRVDATA'
"replace","with"
"omw","On my way"
"chnage","change"
"idk","I don't know"
"tmrw","tomorrow"
"osq1","Hi [name]. I saw your comment on the [group] Facebook group. I understand you are selling your home? What is the property address?"
"osq1-addr","What is the property address so I can look it up on Zillow?"
"osq1-phone","Can I get your phone number so I can call you to discuss?"
"osq1-text","I can send you a text message if you prefer. What is your number?"
"osq2","Why are you selling?"
"osq3","How soon do you want to sell?"
"osq4","Does the house need any repairs before a family with young children can move in?"
"osq5","Are there any amounts owed to contractors?"
"osq6","Are the taxes current?"
"osq6-hoa","Is there an HOA? Are there any rental restrictions? What are they (short term, long term, etc)?"
"osq6-restrictions","Are there any rental restrictions? What are they (short term, long term, etc)?"
"osq7","How much is owed on the mortgage?"
"osq8","How much do you need for the property? Is that flexible?"
"osq9","What is the monthly mortgage payment?"
"osq10","If I were to pay you the [x] price, cover all the closing costs, fees, and buy it as is would you be open to terms?"
"osq10-terms","Let me explain how we can make this process incredibly simple and beneficial for you. We often buy homes by taking over existing payments or creating a payment plan that works for you. This means you get more money over time, without any hassle or fees – and we handle everything, so you don't have to lift a finger. You walk away with more cash in your pocket, no closing costs, and we take care of all the repairs and expenses. Would something like this work for you?"
"osq10-terms-yes","Fantastic! Let's schedule a quick call to go over the next steps. I'll handle everything, and you'll see how easy this process can be."
"osq10-cash-fixer","I understand that you're looking for a cash option. Since the house needs some repairs, we could explore an all-cash offer that allows you to sell quickly without making any fixes. If we were to pay all cash and close when you want, what's the least you would take for the property?"
"osq10-cash-turnkey","I understand that you're looking for a cash offer at full market value. Just so you know, when we pay cash, it's typically because the property needs a lot of work, and we're getting it at a discount. Since your home is in great condition, our seller finance option allows us to pay much more. This means you walk away with more money and avoid all the typical hassles. If cash at retail is your only option, you might be better off listing with a real estate agent to get that full market value. Would you be open to discussing how we could make this work on terms that might actually benefit you more?"
"why-lien","We ask because if there are any back taxes or mechanical liens owed on the home it could possibly cause delays with closing."
"why-tax","We ask because if there are any back taxes or mechanical liens owed on the home it could possibly cause delays with closing."
"why-mortgage","There are a couple of ways I can buy your home. I just want to figure out what works best."
"why-phone","Sometimes, Facebook or email can be unreliable, and I want to make sure we can stay in touch. What's the best number to reach you?"
"why-sell","Understanding your reason for selling helps me customize an offer that aligns with your timeline and goals. What's the main reason you're considering selling?"
"why-timeline","No problem at all. We're super flexible and can close whenever you're ready. Do you have a rough timeframe in mind?"
"why-repairs","I ask because if any repairs are needed, we can handle them, saving you the hassle and expense. So, it doesn't need anything at all?"
"why-balance","Sometimes there's a remaining balance on a mortgage that needs to be settled when we buy the property. It's just to make sure everything is covered properly and there are no surprises. Do you have a rough idea of how much you owe?"
"why-pymt","It's just part of the process to help us make an accurate offer. Do you have a rough idea of what that monthly amount is?"
"why-offer","Before I give you an offer, I'd obviously have to see the property and before I do that I need a rough idea of what you're asking."
"why-asking-price","I want to make sure our offer is fair and meets your expectations, so it's helpful to know what you're looking for. Do you have a ballpark figure in mind?"
"why-think","What part do you need to think about? Maybe I can help resolve any unanswered questions?"
"csq1","Is now still a good time?"
"csq2","If we come to an agreement that you're happy with, are you ready to move forward with our offer today? Is there anyone such as a spouse or family member that would be upset if you were to make a decision without discussing it with them first? Is there a good time where I can hop on a call with you and your [person] together?"
"csq3","What's the least you could accept on the price if we can agree on terms?"
"csq4","What's the least down you would take? How close to that can you get?"
"csq5","What's the most amount of time you'd give us to get you cashed out?"
"csq6","What is the lowest monthly payment you could take? What's the lowest rate you would take? That monthly payment is going to go towards the balance of what I owe you, okay?"
"csq7","Does all of that make sense? If I buy your house at the [price] with [down payment] down and make the monthly payment of [monthly payment] does all of this work for you?"
"when-default","For term agreements, we create what's called a \"mortgage wrap\" contract. That is a contract between us and you that says that if we fail to pay the mortgage, then you can take the property back from us. However, we've never had a late payment or a missed payment. In fact, we pay the mortgage company directly. We make sure that we pay using automated payments so that it automatically comes out of the account. We mostly pay 10 days before the due date just in case there's any issue with technology."
"when-house-damage","We carry landlord insurance that will cover damages to the property and names your lender as \"additional insured\". In addition, we require that tenants carry renters insurance in an amount that is at least the amount owed to you. If there is a claim event then the property will be repaired accordingly to retain or improve its value."
"when-tenant-damage","We do not want this anymore than you do, so, we screen our tenants very thoroughly and very rigorously. Put yourself in our shoes: do you want to get calls at 3 AM on a Sunday or calls from the local sheriff?"
"when-fail-to-pay","First, we do not want to lose money. If we fail to pay you, then we'll lose the house and all the money we've invested in it. Second, as part of the agreement, we'll put a \"mortgage wrap\" contract in place to protect us both. The property will be returned to you by executing a \"deed in lieu of foreclosure.\""
"when-close","We can close as quickly as you want to. If you want to leave quickly, in general, it takes one month to close. The standard purchase and sale agreement contract has a 21 day due diligence period where we will have the property inspected and make sure everything is ready for close. If we continue with the purchase, that means we schedule a closing and that depends on how quickly the title company can get us booked. When would you like to close?"
"ask-attorney","Yes, When do you think you'll be able to get this to your attorney? Lets set up a call. Be sure to ask your attorney \"When can they review it?\", and \"When can they get back to you?\""
"def-balloon","On or before the end of the agreed upon term, we'll pay you the remainder of what is owed on the property in a single \"balloon\" payment."
"def-terms","Terms refers to a arrangement where instead of paying all cash upfront, we make regular payments to you over time. This often allows us to pay you more overall while giving you consistent income. We can structure these terms to fit your specific needs, whether that's monthly payments, a larger down payment, or a specific payoff timeline."
"send-email-offer","I'd love to do that; unfortunately it's company policy that we can't just leave open offers floating out there. We are looking at dozens of houses every day. Therefore, I am required to send you the written offer and review it TOGETHER to make sure that I can answer all of your questions and make sure you are 100% comfortable with everything."
TRVDATA

# Count new items
new_count=$(grep -c "," /tmp/trv_data.csv)
new_count=$((new_count - 1)) # Subtract header

echo "Adding $new_count new text replacements..."

# Add new text replacements
# Skip the header row
tail -n +2 /tmp/trv_data.csv | while IFS=, read -r replace with; do
    # Remove surrounding quotes and unescape internal quotes
    replace=$(echo "$replace" | sed 's/^"//;s/"$//' | sed 's/""/"/g')
    with=$(echo "$with" | sed 's/^"//;s/"$//' | sed 's/""/"/g')
    
    osascript <<EOT
    tell application "System Settings"
        activate
    end tell
    
    delay 1
    
    tell application "System Events"
        tell process "System Settings"
            click menu item "Keyboard" of menu "View" of menu bar 1
            delay 1
            click button "Text Replacements" of group 1 of scroll area 1 of group 1 of window "Keyboard"
            delay 1
            
            click button "+" of group 1 of window "Keyboard"
            delay 0.5
            
            # Enter the replacement text (right column)
            keystroke "$with"
            keystroke tab
            
            # Enter the shortcut (left column)
            keystroke "$replace"
            keystroke return
            
            delay 0.5
        end tell
    end tell
EOT
done

# Clean up
rm /tmp/trv_data.csv

echo "Operation completed successfully!"
echo "Summary:"
echo "  - Backed up $backup_count text replacements to: $backup_file"
echo "  - Deleted all existing text replacements"
echo "  - Added $new_count new text replacements"

# Check if text replacements need to be synced with iCloud
osascript <<EOT
tell application "System Events"
    tell process "System Settings"
        set syncButton to button "Sync this data across your devices with iCloud" of group 1 of window "Keyboard"
        if exists syncButton then
            if value of attribute "AXValue" of syncButton is 0 then
                display dialog "Note: Your text replacements are not being synced with iCloud. You may want to enable this in Keyboard settings."
            end if
        end if
    end tell
end tell
EOT

echo "Done!"
