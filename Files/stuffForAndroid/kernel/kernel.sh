#!/system/bin/sh
# Lets find the correct android version
# JoinTheRealms 4/02/14

# Reworked by laufersteppenwolf
# to use the default ramdisk and only the new kernel
#

cd /data/media/tmp
touch ./log
exec >> ./log
exec 2>&1


### Unpack current bootimage
/sbin/busybox dd if=/dev/block/mmcblk0p2 of=/data/media/tmp/oldboot.img
/data/media/tmp/kernel/unpackbootimg -i /data/media/tmp/oldboot.img -o /data/media/tmp/

### Recompiling the new bootimage
/data/media/tmp/kernel/mkbootimg --kernel /data/media/tmp/zImages/$kernelversion --ramdisk /data/media/tmp/boot.img-ramdisk.gz -o /data/media/tmp/newboot.img

### Writing new bootimage
dd if=/data/media/tmp/kernel/newboot.img of=/dev/block/mmcblk0p2

### Copying modules
cp -rf /data/media/tmp/modules/$kernelversion/* /system/lib/modules/*


#### In case a kernel needs a special ramdisk
#### Gonna leave this here, but commented out as we don't need it
#androidVersion=`getprop ro.build.version.release`
#
#
#if [ $androidVersion = "4.1.*" ];then
#	cp -r /data/media/tmp/ramdisks/4.1/* /data/media/tmp/kernel/initrd.img
#	echo "found 4.1.x ROM!"
#fi
#
#if [ $androidVersion = "4.2.*" ];then
#	cp -r /data/media/tmp/ramdisks/4.2/* /data/media/tmp/kernel/initrd.img
#	echo "found 4.2.x ROM!"
#fi
#	
#if [ $androidVersion = "4.3.*" ];then
#	cp -r /data/media/tmp/ramdisks/4.3/* /data/media/tmp/kernel/initrd.img
#	echo "found 4.3.x ROM!"
#fi
#
#if [ $androidVersion = "4.4.2" ];then
#	cp -r /data/media/tmp/ramdisks/4.4/* /data/media/tmp/kernel/initrd.img
#	echo "found 4.4.x ROM!"
#fi
#
#cp -r ./zImages/$chsnzImg ./kernel/zImage 
#su -c ./kernel/mkbootimg --kernel /data/media/tmp/kernel/zImage --ramdisk /data/media/tmp/kernel/initrd.img --output /data/media/tmp/kernel/newboot.img
#dd if=/data/media/tmp/kernel/newboot.img of=/dev/block/mmcblk0p2






	
