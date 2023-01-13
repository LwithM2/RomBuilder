#!/bin/bash

# Make the Directory if it doesn't exist
mkdir -p $SYNC_PATH

# Change to the Source Directory
cd $SYNC_PATH

# Init Repo
repo init -u $MANIFEST -b $MANIFEST_BRANCH

# Sync the Sources
curl -X POST "https://api.telegram.org/bot5838326569:AAHDBk9CwwAgRUu1f97lD9Oi1jTaNcXCUFU/sendMessage" -d "chat_id=5202036980&text=开始同步 $MANIFEST_BRANCH 分支代码"
 repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# Clone Trees
git clone --depth=1 $DT_LINK $DT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $VT_LINK $VT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }
git clone --depth=1 $KT_LINK $KT_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Custom
git clone --depth=1 https://github.com/Nem1xx/android_device_xiaomi_mithorium-common.git -b elixir_a13 device/xiaomi/mithorium-common
git clone --depth=1 https://github.com/Mi-Thorium/proprietary_vendor_xiaomi_mithorium-common.git -b a12/master vendor/xiaomi/mithorium-common
git clone --depth=1 https://github.com/Mi-Thorium/android_hardware_mithorium-4.9.git -b lineage-19.1-k4.9 hardware/mithorium-4.9
git clone --depth=1 https://github.com/LineageOS/android_vendor_qcom_opensource_libfmjni.git -b lineage-18.1 vendor/qcom/opensource/libfmjni
git clone --depth=1 https://github.com/mi-sdm439/android_packages_apps_FMRadio.git -b lineage-18.1 packages/apps/FMRadio

# Exit
exit 0
