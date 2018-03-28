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
NETFLIX43_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2 libvpx tremor libvorbis libogg ffmpeg
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
	-DBUILD_DEBUG=ON -DNRDP_HAS_GIBBON_QA=ON -DNRDP_HAS_MUTEX_STACK=ON -DNRDP_HAS_OBJECTCOUNT=ON \
	-DBUILD_PRODUCTION=OFF -DNRDP_HAS_QA=ON -DBUILD_SMALL=OFF -DBUILD_SYMBOLS=ON -DNRDP_HAS_TRACING=ON

#-DGST_VIDEO_RENDERING=gl

define NETFLIX43_INSTALL_STAGING_CMDS
   echo 'NETFLIX43 IN INSTALL STAGING'
endef

NETFLIX43_EXEC_DIR = $(TARGET_DIR)/root/netflix43
NETFLIX43_DATA_DIR = $(NETFLIX43_EXEC_DIR)/data

define NETFLIX43_INSTALL_TARGET_CMDS
   mkdir -p $(NETFLIX43_EXEC_DIR)
   mkdir -p $(NETFLIX43_DATA_DIR)
   cp $(NETFLIX43_DIR)/netflix/src/platform/gibbon/netflix $(NETFLIX43_EXEC_DIR)
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

$(eval $(cmake-package))

