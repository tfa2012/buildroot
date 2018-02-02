################################################################################
#
# gst1-syna-videosink
#
################################################################################

GST1_SYNA_VIDEOSINK_VERSION = acf6a5b2b7a7a9ea417adfa18d3a7db962ad1cfd
GST1_SYNA_VIDEOSINK_SITE_METHOD = git
GST1_SYNA_VIDEOSINK_SITE = git@github.com:Metrological/synaptics-sdk.git
GST1_SYNA_VIDEOSINK_SUBDIR = components/vendor/synaptics/gst/synasink
GST1_SYNA_VIDEOSINK_AUTORECONF_OPTS = "-Icfg"

GST1_SYNA_VIDEOSINK_LICENSE = LGPLv2.1
GST1_SYNA_VIDEOSINK_LICENSE_FILES = COPYING

GST1_SYNA_VIDEOSINK_POST_INSTALL_TARGET_HOOKS += GSTREAMER1_REMOVE_LA_FILES

GST1_SYNA_VIDEOSINK_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-bad

GST1_SYNA_VIDEOSINK_AUTORECONF = YES

GST1_SYNA_VIDEOSINK_CONF_OPTS = --enable-gstreamer1=yes CFLAGS="$(TARGET_CFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include -DLINUX -DEGL_API_FB -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__" \
                CXXFLAGS="$(TARGET_CXXFLAGS) -I ${STAGING_DIR}/usr/include/gstreamer-1.0 -I ${STAGING_DIR}/usr/include/glib-2.0 -I ${STAGING_DIR}/usr/lib/glib-2.0/include -DLINUX -DEGL_API_FB -I ${STAGING_DIR}/usr/include/marvell/osal/include -I ${STAGING_DIR}/usr/include/marvell/amp/inc -D__LINUX__"

define GST1_SYNA_VIDEOSINK_RUN_AUTOCONF
        mkdir -p $(@D)/components/vendor/synaptics/gst/synasink/cfg
endef
GST1_SYNA_VIDEOSINK_PRE_CONFIGURE_HOOKS += GST1_SYNA_VIDEOSINK_RUN_AUTOCONF

define GST1_SYNA_VIDEOSINK_ENTER_BUILD_DIR
        cd $(@D)/components/vendor/synaptics/gst/synasink
endef
GST1_SYNA_VIDEOSINK_PRE_BUILD_HOOKS += GST1_SYNA_VIDEOSINK_ENTER_BUILD_DIR

$(eval $(autotools-package))
