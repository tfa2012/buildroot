WPEFRAMEWORK_LAUNCHER_VERSION = 050a6631ab665d4137c7d7d5647e7a31e8918cbb
WPEFRAMEWORK_LAUNCHER_SITE_METHOD = git
WPEFRAMEWORK_LAUNCHER_SITE = git@github.com:WebPlatformForEmbedded/WPEFPluginLauncher.git
WPEFRAMEWORK_LAUNCHER_INSTALL_STAGING = YES
WPEFRAMEWORK_LAUNCHER_DEPENDENCIES = wpeframework

WPEFRAMEWORK_LAUNCHER_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_LAUNCHER_VERSION}

$(eval $(cmake-package))
