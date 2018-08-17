################################################################################
#
# wdmp-c
#
################################################################################

WDMP_C_VERSION = 9c654d51edb1f98b50aa6c0a1d0b525b7de3dcc4
WDMP_C_SITE_METHOD = git
WDMP_C_SITE = git://github.com/Comcast/wdmp-c.git
WDMP_C_INSTALL_STAGING = YES

#define WDMP_C_INSTALL_TARGET_CMDS
#    cp -a $(@D)/src/libwdmp-c.so* $(TARGET_DIR)/usr/lib
#endef

#define WDMP_C_INSTALL_STAGING_CMDS
#    cp -a $(@D)/src/libwdmp-c.so* $(STAGING_DIR)/usr/lib
#endef
$(eval $(cmake-package))
