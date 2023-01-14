#!/bin/bash

# Change to the Source Directory
cd workspace

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

# Change to the Output Directory
cd out/target/product/Mi439

# List the Files
echo "Files inside workspace/out/target/product/mi439 are:"
ls --color=auto

# Set FILENAME var
FILENAME=Awaken*.zip

# Upload to oshi.at
TIMEOUT=20160


curl -T $FILENAME https://oshi.at/Awaken*.zip/${TIMEOUT} | tee link.txt > /dev/null || { echo "ERROR: Failed to Upload the Build!" && exit 1; }

MIRROR_LINK=$(cat link.txt | grep Download | cut -d\  -f1)

# Show the Download Link
echo "=============================================="
cat link.txt || { echo "ERROR: Failed to Upload the Build!" && exit 1; }
echo "=============================================="

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot5838326569:AAHDBk9CwwAgRUu1f97lD9Oi1jTaNcXCUFU/sendMessage" \
	-d chat_id="5202036980" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Send the Telegram Message

echo -e \
"
🤖 ROM build CI

✅ Build Completed Successfully!

📱 Device: "${DEVICE}"
🖥 Build System: "${MANIFEST_BRANCH}"
🧑🏼‍💻 MANIFEST: "${MANIFEST}"
⬇️ Download Link: <a href=\"${MIRROR_LINK}\">Here</a>
📅 Date: "$(date +%d\ %B\ %Y)"
⏱ Time: "$(date +%T)"
" > tg.html

TG_TEXT=$(< tg.html)

telegram_message "${TG_TEXT}"
echo " "


# Exit
exit 0
