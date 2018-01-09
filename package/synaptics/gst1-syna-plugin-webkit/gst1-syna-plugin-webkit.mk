################################################################################
#
# gst1-syna-plugin-webkit
#
################################################################################

GST1_SYNA_PLUGIN_WEBKIT_VERSION = 4ec3567442687c05bd23c3ae0650d4b9b2042804
GST1_SYNA_PLUGIN_WEBKIT_SITE_METHOD = git
GST1_SYNA_PLUGIN_WEBKIT_SITE = git@github.com:Metrological/synaptics-sdk.git
GST1_SYNA_PLUGIN_WEBKIT_SUBDIR = components/vendor/synaptics/gst/wpewebkit-plugin
GST1_SYNA_PLUGIN_WEBKIT_AUTORECONF_OPTS = "-Icfg"

GST1_SYNA_PLUGIN_WEBKIT_LICENSE = LGPLv2.1
GST1_SYNA_PLUGIN_WEBKIT_LICENSE_FILES = COPYING

GST1_SYNA_PLUGIN_WEBKIT_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES

GST1_SYNA_PLUGIN_WEBKIT_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-bad

GST1_SYNA_PLUGIN_WEBKIT_AUTORECONF = YES

GST1_SYNA_PLUGIN_WEBKIT_CONF_OPTS = --enable-gstreamer-1.0 CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include" \
                CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include"

define GST1_SYNA_PLUGIN_WEBKIT_RUN_AUTOCONF
        mkdir -p $(@D)/components/vendor/synaptics/gst/wpewebkit-plugin/cfg
endef
GST1_SYNA_PLUGIN_WEBKIT_PRE_CONFIGURE_HOOKS += GST1_SYNA_PLUGIN_WEBKIT_RUN_AUTOCONF

define GST1_SYNA_PLUGIN_WEBKIT_ENTER_BUILD_DIR
        cd $(@D)/components/vendor/synaptics/gst/wpewebkit-plugin
endef
GST1_SYNA_PLUGIN_WEBKIT_PRE_BUILD_HOOKS += GST1_SYNA_PLUGIN_WEBKIT_ENTER_BUILD_DIR

$(eval $(autotools-package))
