################################################################################
#
# WPETVControl
#
################################################################################

WPETVPLATFORMBCM_VERSION = eabd90714cd34070ee86d139658a764a198b7b98
WPETVPLATFORMBCM_SITE_METHOD = git
WPETVPLATFORMBCM_SITE = git@github.com:WebPlatformForEmbedded/WPETVPlatformBCM.git
WPETVPLATFORMBCM_INSTALL_STAGING = YES
WPETVPLATFORMBCM_DEPENDENCIES = wpeframework

WPETVPLATFORMBCM_CONF_OPTS += \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
    -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -D_GNU_SOURCE" \
     $(WPETVPLATFORMBCM_FLAGS)

$(eval $(cmake-package))
