#!/usr/bin/env bash

set -euo pipefail

if [ X"$(uname -m)" == X"x86_64" ]; then
  export UBUNTU_ARCH="amd64"
elif [ X"$(uname -m)" == X"armv7l" ]; then
  export UBUNTU_ARCH="armhf"
else
  echo "ERROR: unknown machine architecture"
  exit 1
fi
#UBUNTU_CORE="ubuntu-base-${UBUNTU_VERSION}-core-${UBUNTU_ARCH}.tar.gz"
UBUNTU_CORE="ubuntu-base-${UBUNTU_FULL_VERSION}-base-${UBUNTU_ARCH}.tar.gz"

echo "Downloading the base image..."
if [ ! -e "${UBUNTU_CORE}" ]; then
  wget "http://cdimage.ubuntu.com/ubuntu-base/releases/${UBUNTU_VERSION}/release/${UBUNTU_CORE}"
fi

rm -f SHA256SUMS
wget "http://cdimage.ubuntu.com/ubuntu-base/releases/${UBUNTU_VERSION}/release/SHA256SUMS"
sha256sum --strict --ignore-missing --check SHA256SUMS || {
  set +e
  CKSUM="$(sha256sum --strict --check SHA256SUMS)"
  set -e
  echo "$CKSUM" | grep "^$UBUNTU_CORE: OK"
}

gzip -cd "${UBUNTU_CORE}" | docker import - chaznet/${UBUNTU_ARCH}-ubuntu_core:${UBUNTU_VERSION}

echo "Building the image..."
docker-compose build ubuntu
