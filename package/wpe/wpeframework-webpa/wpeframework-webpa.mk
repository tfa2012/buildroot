################################################################################
#
# wpeframework-webpa
#
################################################################################

WPEFRAMEWORK_WEBPA_VERSION = 0001
WPEFRAMEWORK_WEBPA_SITE_METHOD = git
WPEFRAMEWORK_WEBPA_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginAVNClient.git
WPEFRAMEWORK_WEBPA_INSTALL_STAGING = YES
WPEFRAMEWORK_WEBPA_DEPENDENCIES = wpeframework

WPEFRAMEWORK_WEBPA_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_WEBPA_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_WEBPA_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))

