################################################################################
#
# cjwt
#
################################################################################

CJWT_VERSION = 39a2823156b1320aa2d07d17d83334f2cbade7f6
CJWT_SITE_METHOD = git
CJWT_SITE = git://github.com/Comcast/cjwt.git
CJWT_INSTALL_STAGING = YES

$(eval $(cmake-package))
