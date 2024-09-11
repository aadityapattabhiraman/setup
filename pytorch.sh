#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run with sudo privileges. Exiting."
  exit 1
fi

LATEST_CUDA_VERSION=`curl -s https://pytorch.org/get-started/locally/ | grep -oP '(?<=CUDA )\d+(?:\.\d+)*' | sort -V | tail -1`

CUDA_ARCHIVE_URL="https://archive.archlinux.org/packages/c/cuda/"
PACKAGE_LIST=$(curl -s $CUDA_ARCHIVE_URL | grep -oP '(?<=href=")cuda-'$LATEST_CUDA_VERSION'[^"]+\.pkg\.tar\.zst')
LATEST_PACKAGE=$(echo "$PACKAGE_LIST" | sort -V -r | head -1)

FULL_PACKAGE_NAME="https://archive.archlinux.org/packages/c/cuda/$LATEST_PACKAGE"

echo "Downloading $FULL_PACKAGE_NAME"

curl -O $FULL_PACKAGE_NAME
PACKAGE_FILE_NAME=$(basename $FULL_PACKAGE_NAME)

echo "Installing $PACKAGE_FILE_NAME"
yes | pacman -Udd $PACKAGE_FILE_NAME

echo "Removing downloaded package file $PACKAGE_FILE_NAME"
rm $PACKAGE_FILE_NAME

echo "Adding cuda to IgnorePkg in /etc/pacman.conf"
sed -i '/^IgnorePkg/ s/$/, cuda/' /etc/pacman.conf

echo "Enter a name for your virtual environment:"
read VENV_NAME

python -m venv $VENV_NAME
echo "Virtual environment created successfully!"
source $VENV_NAME/bin/activate

LATEST_CUDA_VERSION=`curl -s https://pytorch.org/get-started/locally/ | grep -oP '(?<=CUDA )\d+(?:\.\d+)*' | sort -V | tail -1`
CUDA_VERSION_NO_DECIMAL=${LATEST_CUDA_VERSION//./}
RUN_COMMAND="pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu"$CUDA_VERSION_NO_DECIMAL

echo "Run the following command to install PyTorch:"
echo "$RUN_COMMAND"
# source $VENV_NAME/bin/activate
# $RUN_COMMAND