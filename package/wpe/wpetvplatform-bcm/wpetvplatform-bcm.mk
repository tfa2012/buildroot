################################################################################
#
# WPETVPlatform
#
################################################################################

WPETVPLATFORM_BCM_VERSION = 7971af8d4cca58a14090cd45bbccf1e4796743a9
WPETVPLATFORM_BCM_SITE_METHOD = git
WPETVPLATFORM_BCM_SITE = git@github.com:WebPlatformForEmbedded/WPETVPlatformBCM.git
WPETVPLATFORM_BCM_INSTALL_STAGING = YES
WPETVPLATFORM_BCM_DEPENDENCIES = wpeframework

WPETVPLATFORM_BCM_CONF_OPTS += -DBUILD_REFERENCE=${WPETVPLATFORM_BCM_VERSION}

ifeq ($(BR2_PACKAGE_WPETVPLATFORM_BCM_DEBUG),y)
WPETVPLATFORM_BCM_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

$(eval $(cmake-package))
