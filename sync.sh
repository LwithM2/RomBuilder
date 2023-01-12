#!/bin/bash

# Make the Directory if it doesn't exist
mkdir -p $SYNC_PATH

# Change to the Source Directory
cd $SYNC_PATH

# Init Repo
repo init -u $MANIFEST -b $MANIFEST_BRANCH

# Sync the Sources
 repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# Clone Trees
git clone --depth=1 $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $VT_LINK $VT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $KT_LINK $KT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Custom
git clone --depth=1 https://github.com/Mi-Thorium/android_device_xiaomi_mithorium-common.git device/xiaomi/mithorium-common
git clone --depth=1 https://github.com/Mi-Thorium/proprietary_vendor_xiaomi_mithorium-common.git -b a12/master vendor/xiaomi/mithorium-common

# Exit
exit 0
