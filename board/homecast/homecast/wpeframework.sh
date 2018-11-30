#!/bin/sh
export SOURCE=/tmp/nfs/metrological
export LD_LIBRARY_PATH=$SOURCE/usr/lib:$SOURCE/lib:/lib/:usr/lib
export PATH=$PATH:$SOURCE/usr/bin

export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

# Added missing paths
export FONTCONFIG_PATH=/tmp/nfs/metrological/etc/fonts/
export XKB_CONFIG_ROOT=/tmp/nfs/metrological/usr/share/X11/xkb/
export GIO_MODULE_DIR=$SOURCE/usr/lib/gio/modules

# Enable GST debugging
#export GST_DEBUG=3

# Drop caches
echo 3 > /proc/sys/vm/drop_caches

# Core files
#mkdir -p /tmp/nfs/metrological/cores
#echo 1 > /proc/sys/kernel/core_uses_pid
#echo 2 > /proc/sys/fs/suid_dumpable
#echo "/tmp/nfs/metrological/cores/core--process%E" > /proc/sys/kernel/core_pattern
#ulimit -c unlimited

# Firewall for non-prod builds
LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.21:/lib/libnexus.so WPEFramework -c $SOURCE/etc/WPEFramework/config.json
