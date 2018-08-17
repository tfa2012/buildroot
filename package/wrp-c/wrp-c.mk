################################################################################
#
# wrp-c
#
################################################################################

WRP_C_VERSION = 421447302e647930f7dce80f75f8946275086979
WRP_C_SITE_METHOD = git
WRP_C_SITE = git://github.com/Comcast/wrp-c.git
WRP_C_INSTALL_STAGING = YES

$(eval $(cmake-package))
