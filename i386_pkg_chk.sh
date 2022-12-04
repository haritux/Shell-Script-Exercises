#!/bin/bash
# Author: Hareesh Harihar
# haritux.in

# Prepare the ground
NOW=`date +%Y%b%d-%H%M%S`
mkdir ~/i386_removal
df -h > ~/i386_removal/DISK_BEFORE_$NOW.log
REMOVED=~/i386_removal/i386_purge_$NOW.log
NOT_REMOVED=~/i386_removal/i386_not_removed_$NOW.log
touch $REMOVED $NOT_REMOVED
for i in `dpkg -l | grep i386 | awk '{print $2}' | cut -f1 -d:`
 do
   dpkg -l | grep  $i:amd64 > /dev/null 2> /dev/null
   if [ $? -eq 0 ];then
      echo "Removing $i:i386" >> $REMOVED
      sudo apt remove -y --purge $i:i386
   else
      echo "Not removing $i:i386 because an equivalent amd64 package is not installed" >> $NOT_REMOVED
   fi
 done
 df -h > ~/i386_removal/DISK_AFTER_$NOW.log
