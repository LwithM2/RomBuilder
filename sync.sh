#!/bin/bash

ls

#sudo apt install curl
#curl -X POST "https://api.telegram.org/bot5838326569:AAHDBk9CwwAgRUu1f97lD9Oi1jTaNcXCUFU/sendMessage" -d "chat_id=5202036980&text=开始安装所需依赖..."
#sudo apt update
#sudo apt -y upgrade
#sudo apt -y install git-core gnupg flex bison gperf zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip python make openjdk-8-jdk 
#mkdir ~/bin
#curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
#chmod a+x ~/bin/repo
#sudo ln -sf ~/bin/repo /usr/bin/repo
#mkdir workspace
#cd workspace
#echo "workspace-folder=$(pwd)" >> $GITHUB_OUTPUT
#git config --global user.name "Captain Throwback"
#git config --global user.email "captainthrowback@hotmail.com"

# Init Repo
repo init -u https://github.com/Project-Awaken/android_manifest.git -b 12.1
git clone https://github.com/lanmiemie/local_manifests.git --depth 1 -b patch-1 .repo/local_manifests

# Sync the Sources
curl -X POST "https://api.telegram.org/bot5838326569:AAHDBk9CwwAgRUu1f97lD9Oi1jTaNcXCUFU/sendMessage" -d "chat_id=5202036980&text=开始同步 12.1 分支代码"
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
