################################################################################
#
# WPEFramework PlayGiga
#
################################################################################

WPEFRAMEWORK_PLAYGIGA_VERSION = d9b8b196c58bd2a52a8f47ba2ccd352c8d0989da
WPEFRAMEWORK_PLAYGIGA_SITE_METHOD = git
WPEFRAMEWORK_PLAYGIGA_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginPlayGiga.git
WPEFRAMEWORK_PLAYGIGA_INSTALL_STAGING = YES
WPEFRAMEWORK_PLAYGIGA_DEPENDENCIES = wpeframework playgiga

WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_PLAYGIGA_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_PLAYGIGA_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

