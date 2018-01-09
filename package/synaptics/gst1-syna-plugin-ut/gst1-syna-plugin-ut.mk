################################################################################
#
# gst1-syna-plugin-webkit
#
################################################################################

GST1_SYNA_PLUGIN_UT_VERSION = 4ec3567442687c05bd23c3ae0650d4b9b2042804
GST1_SYNA_PLUGIN_UT_SITE_METHOD = git
GST1_SYNA_PLUGIN_UT_SITE = git@github.com:Metrological/synaptics-sdk.git
GST1_SYNA_PLUGIN_UT_SUBDIR = components/vendor/synaptics/gst/wpewebkit-ut
GST1_SYNA_PLUGIN_UT_AUTORECONF_OPTS = "-Icfg"

GST1_SYNA_PLUGIN_UT_LICENSE = LGPLv2.1
GST1_SYNA_PLUGIN_UT_LICENSE_FILES = COPYING

GST1_SYNA_PLUGIN_UT_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES

GST1_SYNA_PLUGIN_UT_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-bad

GST1_SYNA_PLUGIN_UT_AUTORECONF = YES

GST1_SYNA_PLUGIN_UT_CONF_OPTS = --enable-gstreamer-1.0 CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include" \
                CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include"

define GST1_SYNA_PLUGIN_UT_RUN_AUTOCONF
        mkdir -p $(@D)/components/vendor/synaptics/gst/wpewebkit-ut/cfg
endef
GST1_SYNA_PLUGIN_UT_PRE_CONFIGURE_HOOKS += GST1_SYNA_PLUGIN_UT_RUN_AUTOCONF

define GST1_SYNA_PLUGIN_UT_ENTER_BUILD_DIR
        cd $(@D)/components/vendor/synaptics/gst/wpewebkit-ut
endef
GST1_SYNA_PLUGIN_UT_PRE_BUILD_HOOKS += GST1_SYNA_PLUGIN_UT_ENTER_BUILD_DIR

$(eval $(autotools-package))
