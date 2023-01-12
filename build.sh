#!/bin/bash

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

✔️ The Build has been Triggered!

📱 Device: "${DEVICE}"
🖥 Build System: "${MANIFEST_BRANCH}"
🧑🏼‍💻 MANIFEST: "${MANIFEST}"
🌲 Logs: <a href=\"https://cirrus-ci.com/build/${CIRRUS_BUILD_ID}\">Here</a>
" > tg.html

TG_TEXT=$(< tg.html)

telegram_message "${TG_TEXT}"
echo " "


# Change to the Source Directory
cd $SYNC_PATH

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    export USE_CCACHE=1
    ccache -M 60G
    ccache -z
else
    export USE_CCACHE=1
    ccache -M 60G
    ccache -z
fi

# Prepare the Build Environment
sudo free -m
sudo dd if=/dev/zero of=/var/swap bs=1024 count=12562912
mkswap /var/swap
chmod -R 0600 /var/swap
swapon /var/swap
source build/envsetup.sh
export USE_GAPPS=true

# lunch the target
lunch ${LUNCH_COMBO} || { echo "ERROR: Failed to lunch the target!" && exit 1; }

# Build the Code
if [ -z "$J_VAL" ]; then
    mka -j$(nproc --all) $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
elif [ "$J_VAL"="0" ]; then
    mka $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
else
    mka -j${J_VAL} $TARGET || { echo "ERROR: Build Failed!" && exit 1; }
fi

# Exit
exit 0
