################################################################################
#
# netflix 4.3
#
################################################################################

NETFLIX43_VERSION = a0c4845969ebd8ef13464d05c1b76e32eb0a31c7
NETFLIX43_SITE = git@github.com:Metrological/netflix.git
NETFLIX43_SITE_METHOD = git
NETFLIX43_LICENSE = PROPRIETARY
# TODO: check if all deps are really needed, e.g. decoders once gstreamer sink is selected
NETFLIX43_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2 wpeframework playready libvpx tremor libvorbis libogg ffmpeg
NETFLIX43_INSTALL_STAGING = YES
NETFLIX43_INSTALL_TARGET = YES
NETFLIX43_SUBDIR = netflix
NETFLIX43_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX43_RESOURCE_LOCATION})

NETFLIX43_CONF_ENV += TOOLCHAIN_DIRECTORY=$(STAGING_DIR)/usr LD=$(TARGET_CROSS)ld

# TODO: disable hardcoded build type, check if all args are really needed.
NETFLIX43_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Debug \
	-DBUILD_DPI_DIRECTORY=$(@D)/partner/dpi \
	-DCMAKE_INSTALL_PREFIX=$(@D)/release \
	-DCMAKE_OBJCOPY="$(TARGET_CROSS)objcopy" \
	-DCMAKE_STRIP="$(TARGET_CROSS)strip" \
	-DBUILD_COMPILE_RESOURCES=ON \
	-DBUILD_SYMBOLS=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DGIBBON_SCRIPT_JSC_DYNAMIC=OFF \
	-DGIBBON_SCRIPT_JSC_DEBUG=OFF \
	-DNRDP_HAS_IPV6=ON \
	-DNRDP_CRASH_REPORTING="off" \
	-DNRDP_TOOLS="manufSSgenerator" \
	-DDPI_IMPLEMENTATION=gstreamer \
	-DGIBBON_GRAPHICS=rpi-egl \
	-DBUILD_DEBUG=ON -DNRDP_HAS_GIBBON_QA=ON -DNRDP_HAS_OBJECTCOUNT=ON \
	-DBUILD_PRODUCTION=OFF -DNRDP_HAS_QA=ON -DBUILD_SMALL=OFF -DBUILD_SYMBOLS=ON -DNRDP_HAS_TRACING=ON

#-DGST_VIDEO_RENDERING=gl
#-DNRDP_HAS_MUTEX_STACK=ON

define NETFLIX43_INSTALL_STAGING_CMDS
   echo 'NETFLIX43 IN INSTALL STAGING'
endef

ifeq ($(BR2_PACKAGE_NETFLIX43_LIB), y)
NETFLIX43_CONF_OPTS += -DGIBBON_MODE=shared
NETFLIX43_FLAGS = -fPIC
else
NETFLIX43_CONF_OPTS += -DGIBBON_MODE=executable
endif

ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX43_CONF_OPTS += -DGIBBON_INPUT=wpeframework
NETFLIX43_DEPENDENCIES = wpeframework-plugins
else
NETFLIX43_CONF_OPTS += -DGIBBON_INPUT=devinput
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX43_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
NETFLIX43_DEPENDENCIES += WPEFramework
endif

ifeq ($(BR2_PACKAGE_NETFLIX43_GST_GL),y)
  NETFLIX43_CONF_OPTS += -DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_NETFLIX43_MARVEL),y)
  NETFLIX43_CONF_OPTS += -DGST_VIDEO_RENDERING=synaptics
  NETFLIX43_DEPENDENCIES += westeros westeros-sink
else ifeq ($(BR2_PACKAGE_NETFLIX43_WESTEROS_SINK),y)
  NETFLIX43_CONF_OPTS += -DGST_VIDEO_RENDERING=westeros
  NETFLIX43_DEPENDENCIES += westeros westeros-sink
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)

ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework 
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl 
else
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=rpi-egl
endif	
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_GL)$(BR2_PACKAGE_NETFLIX43_WESTEROS_SINK),yn)
NETFLIX43_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=gl
else ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX43_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif

NETFLIX43_DEPENDENCIES += libgles libegl

else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yy)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wpeframework
else ifeq ($(BR2_PACKAGE_WESTEROS)$(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR),yn)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl
else
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=nexus \
	-DGST_VIDEO_RENDERING=bcm-nexus
endif	

NETFLIX43_DEPENDENCIES += libgles libegl

ifeq ($(BR2_PACKAGE_HOMECAST_SDK),y)
NETFLIX43_CONF_OPTS += -DNO_NXCLIENT=1
endif
else ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=intelce
NETFLIX43_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
NETFLIX43_CONF_OPTS += \
	-DNRDP_SCHEDULER_TYPE=rr \
	-DGIBBON_TCMALLOC=OFF \
	-DGIBBON_GRAPHICS=intelce \
	-DDPI_REFERENCE_HAVE_DDPLUS=true
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
NETFLIX43_CONF_OPTS += \
	-DGST_VIDEO_RENDERING=horizon-fusion
endif
NETFLIX43_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_KYLIN_GRAPHICS),y)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=wayland-egl
NETFLIX43_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyn)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-egl
NETFLIX43_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES)$(BR2_PACKAGE_MESA3D),yyy)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2-mesa
NETFLIX43_DEPENDENCIES += libgles libegl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=gles2
NETFLIX43_DEPENDENCIES += libgles
else
NETFLIX43_CONF_OPTS += \
	-DGIBBON_GRAPHICS=null
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
	NETFLIX43_CONF_OPTS += -DNETFLIX_USE_PROVISION=ON
	NETFLIX43_DEPENDENCIES += wpeframework
endif
ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
	NETFLIX43_CONF_OPTS += -DUSE_NETFLIX_VIRTUAL_KEYBOARD=1
	NETFLIX43_DEPENDENCIES += wpeframework
endif

ifneq ($(BR2_PACKAGE_NETFLIX43_KEYMAP),"")
NETFLIX43_CONF_OPTS += -DNETFLIX_USE_KEYMAP=$(call qstrip,$(BR2_PACKAGE_NETFLIX43_KEYMAP))
endif

NETFLIX43_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(NETFLIX43_FLAGS)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(NETFLIX43_FLAGS)"

ifeq ($(BR2_PACKAGE_NETFLIX43_LIB),y)

define NETFLIX43_INSTALL_STAGING_CMDS
	make -C $(@D)/netflix install
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(STAGING_DIR)/usr/lib
	$(INSTALL) -D package/netflix43/netflix.pc $(STAGING_DIR)/usr/lib/pkgconfig/netflix.pc
	mkdir -p $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/release/include/* $(STAGING_DIR)/usr/include/netflix/
	cp -Rpf $(@D)/netflix/include/nrdbase/config.h $(STAGING_DIR)/usr/include/netflix/nrdbase/
	mkdir -p $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/bridge/*.h $(STAGING_DIR)/usr/include/netflix
	mkdir -p $(STAGING_DIR)/usr/include/netflix/gibbon
	cp -Rpf $(@D)/netflix/src/platform/gibbon/include/gibbon/*.h $(STAGING_DIR)/usr/include/netflix/gibbon
	$(SED) 's:^using std\:\:isnan;:\/\/using std\:\:isnan;:' \
		-e 's:^using std\:\:isinf:\/\/using std\:\:isinf:' \
		$(STAGING_DIR)/usr/include/netflix/nrdbase/tr1.h
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/*.h $(STAGING_DIR)/usr/include/netflix
	cp -Rpf $(@D)/netflix/src/platform/gibbon/text/freetype/*.h $(STAGING_DIR)/usr/include/netflix
	sed -i 's,isnormal,std::isnormal,' $(STAGING_DIR)/usr/include/netflix/Point.h
endef

NETFLIX43_EXEC_DIR = $(TARGET_DIR)/root/netflix43
NETFLIX43_DATA_DIR = $(NETFLIX43_EXEC_DIR)/data

define NETFLIX43_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/libnetflix.so $(TARGET_DIR)/usr/lib
   rm -rf $(NETFLIX43_EXEC_DIR)
   mkdir -p $(NETFLIX43_EXEC_DIR)
   mkdir -p $(NETFLIX43_DATA_DIR)
   cp -r $(NETFLIX43_DIR)/netflix/src/platform/gibbon/data/* $(NETFLIX43_DATA_DIR)
   cp -r $(NETFLIX43_DIR)/netflix/resources/configuration/* $(NETFLIX43_DATA_DIR)/etc/conf/
   cp $(NETFLIX43_DIR)/partner/eventloop/directfb/eventloop.xml $(NETFLIX43_DATA_DIR)/etc/conf/
   cp $(NETFLIX43_DIR)/partner/graphics/directfb/graphics.xml $(NETFLIX43_DATA_DIR)/etc/conf/
   cp $(NETFLIX43_DIR)/netflix/src/platform/gibbon/resources/configuration/* $(NETFLIX43_DATA_DIR)/etc/conf/
   mkdir -p $(NETFLIX43_DATA_DIR)/etc/certs
   cp $(NETFLIX43_DIR)/netflix/resources/etc/certs/ui_ca.pem $(NETFLIX43_DATA_DIR)/etc/certs
   cp -r $(NETFLIX43_DIR)/netflix/resources/etc/keys $(NETFLIX43_DATA_DIR)/etc/
   cp $(NETFLIX43_DIR)/netflix/src/platform/gibbon/resources/gibbon/fonts/fonts.xml $(NETFLIX43_DATA_DIR)/fonts
   rm -f $(NETFLIX43_DATA_DIR)/dpi
   mkdir -p $(NETFLIX43_DATA_DIR)/dpi
   ln -s /etc/playready/ $(NETFLIX43_DATA_DIR)/dpi/playready
endef

else

define NETFLIX43_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/netflix/src/platform/gibbon/netflix $(TARGET_DIR)/usr/bin
endef

endif

define NETFLIX43_PREPARE_DPI
	mkdir -p $(TARGET_DIR)/root/Netflix/dpi
	ln -sfn /etc/playready $(TARGET_DIR)/root/Netflix/dpi/playready
endef

NETFLIX43_POST_INSTALL_TARGET_HOOKS += NETFLIX43_PREPARE_DPI

$(eval $(cmake-package))

