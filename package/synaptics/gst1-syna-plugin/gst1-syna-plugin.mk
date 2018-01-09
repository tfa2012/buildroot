################################################################################
#
# gst1-syna-plugin
#
################################################################################

GST1_SYNA_PLUGIN_VERSION = 4ec3567442687c05bd23c3ae0650d4b9b2042804
GST1_SYNA_PLUGIN_SITE_METHOD = git
GST1_SYNA_PLUGIN_SITE = git@github.com:Metrological/synaptics-sdk.git
GST1_SYNA_PLUGIN_SUBDIR = components/vendor/synaptics/gst/plugin
GST1_SYNA_PLUGIN_AUTORECONF_OPTS = "-Icfg"

GST1_SYNA_PLUGIN_LICENSE = LGPLv2.1
GST1_SYNA_PLUGIN_LICENSE_FILES = COPYING

GST1_SYNA_PLUGIN_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES

GST1_SYNA_PLUGIN_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-bad

GST1_SYNA_PLUGIN_AUTORECONF = YES

export PKG_CONFIG_SYSROOT_DIR="${STAGING_DIR}"

GST1_SYNA_PLUGIN_CONF_OPTS = --with-sysroot $(STAGING_DIR) --enable-gstreamer-1.0 CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__" \
                CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__"

define GST1_SYNA_PLUGIN_RUN_AUTOCONF
        mkdir -p $(@D)/components/vendor/synaptics/gst/plugin/cfg
endef
GST1_SYNA_PLUGIN_PRE_CONFIGURE_HOOKS += GST1_SYNA_PLUGIN_RUN_AUTOCONF

define GST1_SYNA_PLUGIN_ENTER_BUILD_DIR
        cd $(@D)/components/vendor/synaptics/gst/plugin
endef
GST1_SYNA_PLUGIN_PRE_BUILD_HOOKS += GST1_SYNA_PLUGIN_ENTER_BUILD_DIR

$(eval $(autotools-package))
