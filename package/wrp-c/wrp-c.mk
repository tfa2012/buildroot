################################################################################
#
# wrp-c
#
################################################################################

WRP_C_VERSION = f227dacb6752a62bdb78e79868cdb6d07148fe04
WRP_C_SITE_METHOD = git
WRP_C_SITE = git://github.com/Comcast/wrp-c.git
WRP_C_INSTALL_STAGING = YES

$(eval $(cmake-package))
