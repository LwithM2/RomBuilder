#!/bin/bash

# Make the Directory if it doesn't exist
mkdir -p ~/project/work

# Change to the Source Directory
cd ~/project/work

# Init Repo
repo init -u $MANIFEST -b $MANIFEST_BRANCH
git clone https://github.com/lanmiemie/local_manifests.git --depth 1 -b patch-1 .repo/local_manifests

# Sync the Sources
curl -X POST "https://api.telegram.org/bot5838326569:AAHDBk9CwwAgRUu1f97lD9Oi1jTaNcXCUFU/sendMessage" -d "chat_id=5202036980&text=开始同步 $MANIFEST_BRANCH 分支代码"
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# Clone Trees
#git clone --depth=1 $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
#git clone --depth=1 $VT_LINK $VT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
#git clone --depth=1 $KT_LINK $KT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Custom
#git clone --depth=1 https://github.com/Mi-Thorium/android_device_xiaomi_mithorium-common.git -b a12/rom/awaken device/xiaomi/mithorium-common
#git clone --depth=1 https://github.com/Mi-Thorium/proprietary_vendor_xiaomi_mithorium-common.git -b a12/master vendor/xiaomi/mithorium-common

# Exit
exit 0
