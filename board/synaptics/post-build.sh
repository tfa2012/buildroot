#!/bin/sh
set -u
set -e

BOARD_DIR="$(dirname $0)"

#copy board files
mkdir -p "${TARGET_DIR}/www/"
cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"

mkdir -p "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S35wpasupplicant" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S41udhcpc-wlan0" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S42udhcpc-eth0" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S60ampservice" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S61keymap" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S62avsettings" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S63hdcp" "${TARGET_DIR}/etc/init.d/"
cp -pf "${BOARD_DIR}/S65bluetoothd" "${TARGET_DIR}/etc/init.d/"


mkdir -p "${TARGET_DIR}/etc/bluetooth/"
cp -pf "${BOARD_DIR}/main.conf" "${TARGET_DIR}/etc/bluetooth/"

mkdir -p "${TARGET_DIR}/lib/firmware/mrvl"
cp -pf "${BOARD_DIR}/WlanCalData_sd8997.conf" "${TARGET_DIR}/lib/firmware/mrvl"

mkdir -p "${TARGET_DIR}/etc/modprobe.d"
cp -pf "${BOARD_DIR}/bt8xxx.conf" "${TARGET_DIR}/etc/modprobe.d"
cp -pf "${BOARD_DIR}/gal3d.conf" "${TARGET_DIR}/etc/modprobe.d"
cp -pf "${BOARD_DIR}/sd8997.conf" "${TARGET_DIR}/etc/modprobe.d"

mkdir -p "${TARGET_DIR}/etc/udev/hwdb.d"
cp -pf "${BOARD_DIR}/90-remote-keymap.hwdb" "${TARGET_DIR}/etc/udev/hwdb.d"

mkdir -p "${TARGET_DIR}/etc/udev/rules.d"
cp -pf "${BOARD_DIR}/99-wpeframework-input-event.rules" "${TARGET_DIR}/etc/udev/rules.d"

mkdir -p "${TARGET_DIR}/etc/wpa_supplicant"
cp -pf "${BOARD_DIR}/wpa_supplicant.conf" "${TARGET_DIR}/etc/wpa_supplicant/wpa_supplicant-wlan0.conf"

# Add LD_PRELOAD variable to WPEFramework script
sed -i '/LD_PRELOAD/d' "${TARGET_DIR}/etc/init.d/S80WPEFramework"
sed -i '/EGL_MVGFX/d' "${TARGET_DIR}/etc/init.d/S80WPEFramework"
sed -i '/XDG_RUNTIME_DIR/a export LD_PRELOAD=libwesteros_gl.so.0.0.0' "${TARGET_DIR}/etc/init.d/S80WPEFramework"
sed -i '/XDG_RUNTIME_DIR/a export EGL_MVGFX_H=1080' "${TARGET_DIR}/etc/init.d/S80WPEFramework"
sed -i '/XDG_RUNTIME_DIR/a export EGL_MVGFX_W=1920' "${TARGET_DIR}/etc/init.d/S80WPEFramework"

mkdir -p "${TARGET_DIR}/usr/bin"
cp -pf "${BOARD_DIR}/wpe_ampsamples_plugin_start.sh" "${TARGET_DIR}/usr/bin"
cp -pf "${BOARD_DIR}/wpe_ampsamples_plugin_stop.sh" "${TARGET_DIR}/usr/bin"

