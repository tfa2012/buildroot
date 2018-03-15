################################################################################
#
# netflix5
#
################################################################################

NETFLIX5_VERSION = 185ac9d9454970cd186e314a96cc9d7d28e407a2
NETFLIX5_SITE = git@github.com:Metrological/netflix.git
NETFLIX5_SITE_METHOD = git
NETFLIX5_LICENSE = PROPRIETARY
# TODO: check if all deps are really needed, e.g. decoders once gstreamer sink is selected
NETFLIX5_DEPENDENCIES = freetype icu jpeg libpng libmng webp harfbuzz expat openssl c-ares libcurl graphite2 libvpx tremor libvorbis libogg nghttp2 ffmpeg
NETFLIX5_INSTALL_STAGING = YES
NETFLIX5_INSTALL_TARGET = YES
NETFLIX5_SUBDIR = netflix
NETFLIX5_RESOURCE_LOC = $(call qstrip,${BR2_PACKAGE_NETFLIX5_RESOURCE_LOCATION})

NETFLIX5_CONF_ENV += TOOLCHAIN_DIRECTORY=$(STAGING_DIR)/usr LD=$(TARGET_CROSS)ld

# TODO: disable hardcoded build type, check if all args are really needed.
NETFLIX5_CONF_OPTS = \
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
	-DDPI_IMPLEMENTATION=sink-interface \
	-DDPI_SINK_INTERFACE_IMPLEMENTATION=gstreamer \
	-DGIBBON_GRAPHICS=nexus \
	-DBUILD_DEBUG=ON -DNRDP_HAS_GIBBON_QA=ON -DNRDP_HAS_MUTEX_STACK=ON -DNRDP_HAS_OBJECTCOUNT=ON \
	-DBUILD_PRODUCTION=OFF -DNRDP_HAS_QA=ON -DBUILD_SMALL=OFF -DBUILD_SYMBOLS=ON -DNRDP_HAS_TRACING=ON \
	-DNRDP_CRASH_REPORTING=breakpad

define NETFLIX5_INSTALL_STAGING_CMDS
   echo 'NETFLIX5 IN INSTALL STAGING'
endef

define NETFLIX5_INSTALL_TARGET_CMDS
   echo 'NETFLIX5 IN INSTALL TARGET'
endef

$(eval $(cmake-package))
