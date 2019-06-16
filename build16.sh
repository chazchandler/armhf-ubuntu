#!/usr/bin/env bash

set -euo pipefail

export UBUNTU_VERSION="${UBUNTU_VERSION:-16.04}"
export UBUNTU_FULL_VERSION="${UBUNTU_FULL_VERSION:-16.04.6}"

./build.sh
