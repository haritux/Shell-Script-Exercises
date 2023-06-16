#!/bin/bash
# Concatenate two passwords files. The resulting will contain entries of the first file with UID < 500 and that of second with UID > 500
DATE=`date +%d.%m.%Y`
TIME=`date +%H.%M.%S`
echo Name of File 1
read f1
echo Name of File 2
read f2
echo Name for New file
read newfile
mv $newfile $newfile.bak.$DATE.$TIME

## Manipulate first file

## file 2
count=`cat $f2 | cut -f3 -d : | sort -n | wc -l`
count=$(`expr ‘cat count’`)
h=1
while [ “$count” -ge “$h” ]
do
{
id=`head -$h $f2 | tail -1 | cut -f3 -d:`
if [ $id -gt “499” ]
then
{
username=`head -$h $f2 | tail -1 | cut -f1 -d:`
grep $username: $newfile
if [ $? = “0” ]
then
echo “User $username or *$username* already exists in $newfile came from $f1 with UID less than 500”
else
head -$h $f2 | tail -1 >> $newfile
fi
