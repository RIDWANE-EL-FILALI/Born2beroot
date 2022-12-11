#!/bin/bash
#********************************************COMMANTS*************************************************
: '
Make sure to install sysstat : sudo apt install sysstat
Make sure to install bc : sudo apt install bc
uniq=Filter adjacent matching lines from INPUT (or standard input), writing to OUTPUT (or standard output).
     With no options, matching lines are merged to the first occurrence.
     Mandatory arguments to long options are mandatory for short options too
       
sort=SORT command is used to sort a file, arranging the records in a particular order. By default, the sort command 									
     sorts file assuming the contents are ASCII. Using options in the sort command can also be used to sort numerically.
each core on your cpu can act as a vcpu
free=Display amount of free and used memory in the system: -m
NR=NUMBER OF RAWS
vmstat : Report virtual memory statistics
-s : Displays a table of various event counters and memory statistics.  This display does not repeat.
expr= evaluate expressions
mpstat:  Report processors related statistics
netstat: Print network connections, routing tables, interface statistics, masquerade connections, and multicast memberships
-a:Show both listening and non-listening sockets.  With the --interfaces option, show interfaces that are not up
-n:Show numerical addresses instead of trying to determine symbolic host, port or user names.
-t:tcp
users=print the user names of users currently logged in to the current host
NF==last frame
hostname=show or set the system host name
-I=Display  all network addresses of the host. This option enumerates all configured addresses on all network interfaces. The loopback interface and IPv6 link-local addresses are omitted. Contrary to option -i, this option does not depend on name resolution. Do  not
            make any assumptions about the order of the output.
ip=show / manipulate routing, network devices, interfaces and tunnels
addr=protocol (IP or IPv6) address on a device.
jounalctl=journalctl may be used to query the contents of the systemd(1) journal as written by systemd-journald.service(8).
       If called without parameters, it will show the full contents of the journal, starting with the oldest entry collected

'
#*******************************************************VARIABLES**********************************************************
ARC=$(uname -a)
PCPU=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep "^processor" /proc/cpuinfo | wc -l)
RAM=$(free --mega | awk 'NR==2 {print $2}')
URAM=$(free --mega | awk 'NR==2 {print $3}')
PRAM=$(free --mega | awk 'NR==2 {printf("%.2f", $3/$2*100)}')
TOTAL_MEMORY=$(df -Bg | grep '^/dev' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
USED_MEMORY=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
USED_MEMORY_PERCENTAGE=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
CPULOAD=$(echo 100 - $(mpstat | awk 'NR==4 {print $NF}') | bc)
LASTBOOT=$(who -b | awk '{print $3,$4}')
TCP=$(netstat -ant | grep "ESTABLISHED" | wc -l)
ULOG=$(who | awk '{print $1}' | uniq | wc -l)
IP=$(hostname -I)
MAC=$(ip address | grep "link/ether" | awk '{print $2}')
CMD=$(journalctl -q _COMM=sudo | grep "COMMAND" | wc -l)

wall "
	#Architecture: $ARC
	#CPU physical: $PCPU
	#VCPU: $VCPU
	#Memory Usage: $URAM/$RAM MB ($PRAM%)
	#Disk Usage: $USED_MEMORY / $TOTAL_MEMORY GB ($USED_MEMORY_PERCENTAGE%)
	#CPU load: 0$CPULOAD
	#Last boot: $LASTBOOT
	#LVM use: yes
	#TCP CONNECTIONS: $TCP ESTABLISHED
	#User log: $ULOG
	#Network: IP $IP ($MAC)
	#sudo: $CMD cmd"

