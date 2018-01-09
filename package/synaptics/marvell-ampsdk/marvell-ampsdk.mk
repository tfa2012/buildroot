################################################################################
#
# marvell-firmware
#
################################################################################

MARVELL_AMPSDK_VERSION = d4df541e61f549b9d65f9388042e6a25805f459d
MARVELL_AMPSDK_SITE_METHOD = git
MARVELL_AMPSDK_SITE = git@github.com:Metrological/marvell-ampsdk.git

MARVELL_AMPSDK_INSTALL_STAGING = YES
MARVELL_AMPSDK_DEPENDENCIES = 
MARVELL_AMPSDK_LICENSE = CLOSED

AMPSDK_INC_DIRS = amp/inc amp/inc/flick/encode amp/inc/flick/link amp/inc/flick/pres amp/inc/isl osal/include

define MARVELL_AMPSDK_BUILD_CMDS
# nothing to build
endef

define MARVELL_AMPSDK_INSTALL_LIBS
   $(INSTALL) -D -m 644 $(@D)/build/configs/$(1)/prebuilt/linux_bg4cdp_a0_rdk/lib/* $(2)/usr/lib
endef

define MARVELL_AMPSDK_INSTALL_BINS
   $(INSTALL) -D -m 755 $(@D)/build/configs/$(1)/prebuilt/linux_bg4cdp_a0_rdk/bin/* $(2)/usr/bin
endef

define MARVELL_AMPSDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/lib

	$(INSTALL) -D -m 644 $(@D)/products/linux_bg4cdp_a0_rdk/berlin_config_sw.xml $(TARGET_DIR)/etc
	$(INSTALL) -D -m 644 $(@D)/products/linux_bg4cdp_a0_rdk/berlin_config_hw.xml $(TARGET_DIR)/etc

	rm -f $(TARGET_DIR)/usr/lib/libglibc_bridge.so
	rm -f $(TARGET_DIR)/lib/ld-linux.so.3
	ln -s /usr/lib/libglib-2.0.so $(TARGET_DIR)/usr/lib/libglibc_bridge.so
	ln -s /lib/ld-linux-armhf.so.3 $(TARGET_DIR)/lib/ld-linux.so.3

	$(call MARVELL_AMPSDK_INSTALL_BINS,ampservice,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_BINS,test_disp,$(TARGET_DIR))

	$(call MARVELL_AMPSDK_INSTALL_LIBS,libOSAL,$(TARGET_DIR))

	$(call MARVELL_AMPSDK_INSTALL_LIBS,libamprpc_server,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libamputil_server,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libamphal,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libshmserver,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlcommon,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampsrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdrmsrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdispsrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddldummy,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libsndsrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlclk,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdmxcomm,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddldmx,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libtspdrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlvsched,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlvdec,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlacodec,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddladec,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlvout,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libddlaren,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libvppdrv,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libi2c,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampgpio,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdrmkeymgr,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdrmcommca,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdrmcrypto,$(TARGET_DIR))

	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampclient,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libgraphics,$(TARGET_DIR))

	$(call MARVELL_AMPSDK_INSTALL_BINS,logcat,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_BINS,ampdiag,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_BINS,ampclient_samples,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_BINS,ampclient_avsettings,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libdrmclient,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,liblog,$(TARGET_DIR))
endef

define MARVELL_AMPSDK_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include

        $(foreach incdir,$(AMPSDK_INC_DIRS),
                $(INSTALL) -d $(STAGING_DIR)/usr/include/marvell/$(incdir); \
                $(INSTALL) -D -m 0644 $(@D)/$(incdir)/*.h \
                        $(STAGING_DIR)/usr/include/marvell/$(incdir)/
        )
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libOSAL,$(STAGING_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampclient,$(STAGING_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libgraphics,$(STAGING_DIR))
endef

$(eval $(generic-package))
