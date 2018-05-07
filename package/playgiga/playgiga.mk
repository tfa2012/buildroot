################################################################################
#
# playgiga
#
################################################################################

PLAYGIGA_VERSION = aee6ad5bd8da2b6ce8011e048cf9ba161523059c
PLAYGIGA_SITE = git@github.com:Metrological/playgiga.git
PLAYGIGA_SITE_METHOD = git
PLAYGIGA_LICENSE = PROPRIETARY
PLAYGIGA_DEPENDENCIES = sdl2 ffmpeg openal libcurl
PLAYGIGA_INSTALL_STAGING = YES
PLAYGIGA_INSTALL_TARGET = YES
PLAYGIGA_SUBDIR = arm32 # TODO: let it depend on arch

$(eval $(cmake-package))

