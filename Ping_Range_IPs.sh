#!/bin/sh
# An interactive and simple script to ping a set of IPs within a network.
# This is just a hobby script to practise Shell script.
# This will probe for the Network Subnet as an input and PING all IPs in that Subnet.
# Useful to flush/update ARP table.
# Author: haritux.in

PING="$(which ping) -c 1 -W 1"

echo -n "Enter Subnet(eg:192.168.0): "; read Subnet

while :
do
cat << !
1. Ping Entire Network
2. Ping a RANGE
3. Exit
!

echo -n "Your Choice (1/2/3) ?"
read choice

case $choice in

1)
echo Pinging the entire Network...
for((i=1;i<255;i++)); do
${PING} ${Subnet}.${i} > /dev/null 2> /dev/null
if [ $? -eq 0 ];
then
echo -e "${Subnet}.${i} is up"
fi
done
;;

2)
echo Enter the Starting IP of Range
read a
echo Enter the Last IP of Range
read b
echo Pinging.....
for((i=$a;i<$b;i++)); do
${PING} ${Subnet}.${i} > /dev/null 2> /dev/null
if [ $? -eq 0 ];
then
echo -e "${Subnet}.${i} is up"
fi
done
;;

3) clear; exit ;;

*) echo; echo "\"$choice\" is not a valid option."; sleep 2 ;;
esac
done
