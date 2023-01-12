#!/bin/bash

# Make the Directory if it doesn't exist
mkdir -p $SYNC_PATH

# Change to the Source Directory
cd $SYNC_PATH

# Init Repo
repo init -u $MANIFEST -b $MANIFEST_BRANCH

# Sync the Sources
repo sync -j$(nproc --all) --force-sync

# Clone Trees
git clone --depth=1 $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $VT_LINK $VT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $KT_LINK $KT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $CO_LINK $CO_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Custom
rm -rf hardware/xiaomi
rm -rf hardware/qcom-caf/wlan
rm -rf hardware/qcom-caf/bootctrl
rm -rf hardware/google/pixel/kernel_headers
git clone --depth=1 https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-20 hardware/xiaomi
git clone --depth=1 https://github.com/Jabiyeff-Project/android_hardware_qcom_wlan.git -b 13.0-spes hardware/qcom-caf/wlan
git clone --depth=1 https://github.com/ArrowOS/android_hardware_qcom_bootctrl.git -b arrow-13.0-caf hardware/qcom-caf/bootctrl
git clone --depth=1 https://github.com/Mi-Thorium/proprietary_vendor_xiaomi_mithorium-common.git -b a12/master vendor/xiaomi/mithorium-common

# Exit
exit 0
