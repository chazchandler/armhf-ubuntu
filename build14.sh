#!/usr/bin/env bash

set -euo pipefail

export UBUNTU_VERSION="${UBUNTU_VERSION:-14.04}"
export UBUNTU_FULL_VERSION="${UBUNTU_FULL_VERSION:-14.04.5}"

./build.sh
