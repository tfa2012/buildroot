#!/bin/sh

export SOURCE=/hdd/metrological
#export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib
export LD_LIBRARY_PATH=$SOURCE/usr/lib:/lib:/usr/lib:$SOURCE/lib:$SOURCE/usr/lib/wpeframework/plugins:$SOURCE/usr/lib/wpeframework/proxystubs
export PATH=$SOURCE/usr/bin:$PATH
export GST_PLUGIN_SCANNER=$SOURCE/usr/libexec/gstreamer-1.0/gst-plugin-scanner
export GST_PLUGIN_SYSTEM_PATH=$SOURCE/usr/lib/gstreamer-1.0

case "$1" in
bind_acn)
	grep -q "/opt/wpe ext4" /proc/mounts &&
		echo "/opt/wpe is already mounted" || mount -t ext4 --bind $SOURCE /opt/wpe
	grep -q "/etc/ssl ext4" /proc/mounts &&
		echo "/etc/ssl is already mounted" || mount -t ext4 --bind $SOURCE/etc/ssl/ /etc/ssl/
	grep -q "/usr/lib/gio ext4" /proc/mounts &&
		echo "/usr/lib/gio is already mounted" || mount -t ext4 --bind $SOURCE/usr/lib/gio /usr/lib/gio
;;
metrological)
	export DESTINATION=/hdd/acn
	
	# Currently the root system is read-only. Since we cannot add anything there we bind 
	# existing directories with a copy of the actual system. All the stuff we want to 
	# add is symbolicly linked in from our sources..
	if [ ! -d $DESTINATION ]; then

		mkdir -p $DESTINATION/share
		mkdir -p $DESTINATION/etc
		mkdir -p $DESTINATION/lib
		mkdir -p $DESTINATION/bin
		cp -rfap /usr/share/* $DESTINATION/share
		cp -rfap /etc/* $DESTINATION/etc
		cp -rfap /usr/lib/* $DESTINATION/lib
		cp -rfap /usr/bin/* $DESTINATION/bin

		ln -s $SOURCE/usr/share/mime $DESTINATION/share/mime
		ln -s $SOURCE/usr/share/X11 $DESTINATION/share/X11
		ln -s $SOURCE/usr/share/WPEFramework $DESTINATION/share/WPEFramework
		ln -s $SOURCE/usr/share/fonts $DESTINATION/share/fonts
		ln -s $SOURCE/etc/ssl $DESTINATION/etc/ssl
		ln -s $SOURCE/etc/ssl $DESTINATION/lib/ssl
		ln -s $SOURCE/etc/fonts $DESTINATION/etc/fonts
		ln -s $SOURCE/etc/WPEFramework $DESTINATION/etc/WPEFramework
		ln -s $SOURCE/usr/lib/gio $DESTINATION/lib/gio
	fi
	grep -q "/usr/share ext4" /proc/mounts && echo "/usr/share is already mounted" || mount -t ext4 --bind $DESTINATION/share/ /usr/share/
	grep -q "/etc ext4" /proc/mounts && echo "/etc is already mounted" || mount -t ext4 --bind $DESTINATION/etc/ /etc/
	grep -q "/usr/lib ext4" /proc/mounts && echo "/usr/lib is already mounted" || mount -t ext4 --bind $DESTINATION/lib/ /usr/lib/
	grep -q "/usr/bin ext4" /proc/mounts && echo "/usr/bin is already mounted" || mount -t ext4 --bind $DESTINATION/bin /usr/bin/

	#launch rpcbind to create channel between framework and webkit
	ext=`pidof rpcbind`
	if [ ! $ext ]; then
    		echo "Launching rpcbind ..."
		rpcbind 
	else
    		echo "rpcbind is already launched..."
	fi	
	
	#work around for playready
	cd /usr/bin/netflix

	LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.21 WPEFramework
;;

*)
	grep -q "/opt/wpe ext4" /proc/mounts && 
		echo "/opt/wpe is already mounted" || mount -t ext4 --bind /hdd/metrological /opt/wpe
	grep -q "/usr/lib/gio ext4" /proc/mounts &&
		echo "/usr/lib/gio is already mounted" || mount -t ext4 --bind $SOURCE/usr/lib/gio /usr/lib/gio
	
	cd /usr/bin/netflix	
	LD_PRELOAD=$SOURCE/lib/libstdc\+\+.so.6.0.21 WPEFramework -c $SOURCE/etc/WPEFramework/config.json 	
;;
esac

