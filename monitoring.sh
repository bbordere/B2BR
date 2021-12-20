#!/bin/bash
vCPU=$(grep -c processor /proc/cpuinfo)
PCPU=$(grep "physical id" /proc/cpuinfo | uniq |wc -l)
ARCH=$(uname -a)
TCP=$(cat /proc/net/sockstat | awk '$1 == "TCP:" {printf $3}')
IP=$(hostname -i)
U_RAM=$(free -m | awk '$1 == "Mem:" {print $3}')
T_RAM=$(free -m | awk '$1 == "Mem:" {print $2}')
P_RAM=$((100 * U_RAM / T_RAM))
UC=$(users | wc -l)
CPU_L=$(top -bn1 |grep load |awk '{print $12}')
CPU_L=${CPU_L%,}
U_DISK=$(df -h '/' | awk 'NR==2 {print $3}')
U_DISK=${U_DISK%G}
T_DISK=$(df -h '/' | awk 'NR==2 {print $2}')
P_DISK=$(df -h '/' | awk 'NR==2 {print $5}')
L_BOOT=$(who -b | awk '{$1=$2="";print $0}' | cut -d " " -f3-)
LVM_S=$(lsblk | grep "lvm" | wc -l)
LVM_A=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)
SUDO_C=$(journalctl _COMM=sudo -q | grep COMMAND | wc -l)
MAC=$(ip link show | awk '$1 == "link/ether" {print $2}' | awk 'NR==1{print $1}')

echo  "#Architecture : $ARCH"
echo 	"#CPU Physical : $PCPU"
echo 	"#vCPU : $vCPU"
echo 	"#Memory Usage : $U_RAM/${T_RAM}MB ($P_RAM%)"
echo 	"#Disk Usage : $U_DISK/$T_DISK ($P_DISK)"
echo	"#CPU load : $CPU_L%"
echo 	"#Last Boot : $L_BOOT"
echo  "#LVM use : $LVM_A"
echo	"#Connexions TCP : $TCP ESTABLISHED"
echo	"#User log : $UC"
echo	"#Network : IP $IP ($MAC)"
echo	"#Sudo : $SUDO_C cmd"
