################################################################################
#
# marvell-firmware
#
################################################################################

MARVELL_FIRMWARE_VERSION = b9a220c9f4c03a404362a5414fbf1e2db101c5d5
MARVELL_FIRMWARE_SITE_METHOD = git
MARVELL_FIRMWARE_SITE = git@github.com:Metrological/marvell-firmware.git

MARVELL_FIRMWARE_INSTALL_STAGING = YES
MARVELL_FIRMWARE_DEPENDENCIES = wayland marvell-ampsdk
MARVELL_FIRMWARE_LICENSE = CLOSED

define MARVELL_FIRMWARE_BUILD_CMDS
# no buildable targets yet.
endef

ifeq ($(BR2_PACKAGE_MARVELL_FIRMWARE_GFX),y)
define MARVELL_FIRMWARE_INSTALL_GFX_LIBS
   $(INSTALL) -D -m 644 $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/drivers/* $(1)/usr/lib
endef

define MARVELL_FIRMWARE_INSTALL_GFX_DEV
   cp -a $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/include/* $(1)/usr/include
   $(INSTALL) -D -m 644 $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/pkgconfig/* $(1)/usr/lib/pkgconfig
endef

endif

define MARVELL_FIRMWARE_INSTALL_TARGET_CMDS
    $(INSTALL) -m 755 -d $(TARGET_DIR)/usr/lib
    $(call MARVELL_FIRMWARE_INSTALL_GFX_LIBS,$(TARGET_DIR))

    rm -rf $(BINARIES_DIR)/eMMCimg
    cp -rapf $(@D)/prebuilt/eMMCimg $(BINARIES_DIR)/eMMCimg

    rm -rf $(TARGET_DIR)/lib/modules
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/modules
    cp -rapf $(@D)/prebuilt/modules/* $(TARGET_DIR)/lib/modules

    rm -rf $(TARGET_DIR)/lib/firmware
    $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware
    cp -rapf $(@D)/prebuilt/firmware/* $(TARGET_DIR)/lib/firmware
endef

define MARVELL_FIRMWARE_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include
	

    $(call MARVELL_FIRMWARE_INSTALL_GFX_LIBS,$(STAGING_DIR))
    $(call MARVELL_FIRMWARE_INSTALL_GFX_DEV,$(STAGING_DIR))
endef

$(eval $(generic-package))
