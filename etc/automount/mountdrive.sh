#!/bin/bash

#sleep 2
param1=$1

caminho=`echo $param1 | sed 's/-/\//g'`

$caminho > /temp/res


if [ $(mount | grep -c /media/usb) -gt 0 ]
then
    umount /media/usb
fi

sudo mkdir /media/usb
mount -t vfat $caminho /media/usb -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
