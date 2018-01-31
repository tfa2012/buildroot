#!/bin/sh

mkdir -p ${BINARIES_DIR}/eMMCimg/
cp "${BINARIES_DIR}/rootfs.ext4.gz" "${BINARIES_DIR}/eMMCimg/system.subimg.gz"
