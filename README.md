#!/usr/bin/env bash

set -euo pipefail

echo "Downloading the base image..."
export UBUNTU_VERSION="${UBUNTU_VERSION:-16.04}"
UBUNTU_FULL_VERSION="16.04.3"
#UBUNTU_CORE="ubuntu-base-${UBUNTU_VERSION}-core-armhf.tar.gz"
UBUNTU_CORE="ubuntu-base-${UBUNTU_FULL_VERSION}-base-armhf.tar.gz"

if [ ! -e "${UBUNTU_CORE}" ]; then
  wget "http://cdimage.ubuntu.com/ubuntu-base/releases/${UBUNTU_VERSION}/release/${UBUNTU_CORE}"
fi

rm -f SHA256SUMS
wget "http://cdimage.ubuntu.com/ubuntu-base/releases/${UBUNTU_VERSION}/release/SHA256SUMS"
sha256sum --strict --ignore-missing --check SHA256SUMS       

gzip -cd "${UBUNTU_CORE}" | docker import - armv7/armhf-ubuntu_core:${UBUNTU_VERSION}

echo "Building the image..."
docker-compose build ubuntu
