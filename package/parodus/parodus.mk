################################################################################
#
# parodus
#
################################################################################

PARODUS_VERSION = 326e83c177315672ffd50149a6e41ac63e11d23d
PARODUS_SITE_METHOD = git
PARODUS_SITE = git://github.com/Comcast/parodus.git
PARODUS_INSTALL_STAGING = YES

PARODUS_DEPENDENCIES = nopoll cimplog nanomsg msgpack-c cjson trower-base64 wrp-c wdmp-c cjson

PARODUS_CONF_OPTS = \
        -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(PARODUS_INCLUDE_DIRS)" \
        -DBUILD_BR=ON

PARODUS_INCLUDE_DIRS = \
    -I$(STAGING_DIR)/usr/include \
    -I$(STAGING_DIR)/usr/include/cjson \
    -I$(STAGING_DIR)/usr/include/nopoll \
    -I$(STAGING_DIR)/usr/include/wdmp-c \
    -I$(STAGING_DIR)/usr/include/wrp-c \
    -I$(STAGING_DIR)/usr/include/cimplog \
    -I$(STAGING_DIR)/usr/include/nanomsg \
    -I$(STAGING_DIR)/usr/include/trower-base64 \
    -I$(STAGING_DIR)/usr/include/cjwt \
    -I$(STAGING_DIR)/usr/include/ucresolv

$(eval $(cmake-package))
