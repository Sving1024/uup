#!/bin/bash
set -e

init_path=$PWD
mkdir upload_packages

echo $local_path

find $local_path -type f -name "*.iso" -exec cp {} ./upload_packages/ \;
find $local_path -type f -name "*.ISO" -exec cp {} ./upload_packages/ \;
find $local_path -type f -name "*.iso" -exec echo {} \;
find $local_path -type f -name "*.ISO" -exec echo {} \;
find $local_path -type f -name "*.json" -exec cp {} ./upload_packages/ \;
find $local_path -type f -name "*.json" -exec echo {} \;
find $local_path -type f -name "*.iso.sha256.txt" -exec cp {} ./upload_packages/ \;
find $local_path -type f -name "*.iso.sha256.txt" -exec echo {} \;

echo "$RCLONE_CONFIG_NAME"

if [ ! -f ~/.config/rclone/rclone.conf ]; then
    mkdir --parents ~/.config/rclone
    echo "$RCLONE_CONFIG_CONTENT" >> ~/.config/rclone/rclone.conf
fi

cd upload_packages || exit 1

echo "::group::Uploading to remote"
python3 $init_path/upload/upload.py 
echo "::endgroup::"