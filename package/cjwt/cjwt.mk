################################################################################
#
# cjwt
#
################################################################################

CJWT_VERSION = 39a2823156b1320aa2d07d17d83334f2cbade7f6
CJWT_SITE_METHOD = git
CJWT_SITE = git://github.com/Comcast/cjwt.git
CJWT_INSTALL_STAGING = YES

define CJWT_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/libcjwt.so* $(TARGET_DIR)/usr/lib
endef

define CJWT_INSTALL_STAGING_CMDS
    cp -a $(@D)/src/libcjwt.so* $(STAGING_DIR)/usr/lib
endef
$(eval $(cmake-package))
