#!/bin/sh

CPU=$(grep -c processor /proc/cpuinfo)
ARCH=$(uname -a)
TCP=$(netstat -atl | wc -l)
IP=$(hostname -i)

echo "#Architecture : $ARCH"
echo  "#CPU Physical : $CPU"
echo  "#Connexions TCP : $TCP ESTABLISHED"