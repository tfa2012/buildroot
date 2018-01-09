#!/bin/sh
BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"

# Temp rootfs dir
mkdir -p "${ROOTFS_DIR}"

rsync -ar "${TARGET_DIR}/" "${ROOTFS_DIR}"

# Create tar
tar -cvzf "${BINARIES_DIR}/system.tar.gz" -C "${ROOTFS_DIR}" .

# Cleaning up
rm -rf "${ROOTFS_DIR}"
