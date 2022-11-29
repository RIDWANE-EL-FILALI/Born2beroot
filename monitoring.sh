#!/bin/bash
********************************************COMMANTS*************************************************
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
*******************************************************VARIABLES**********************************************************
arc=$(uname -a)   #print the systeme information
pcpu=$(grep "physical id" /proc/cpuinfo | uniq | wc -l)
fram=$(free --mega | awk 'NR==2 {print $2}')     #freeram
uram=$(free --mega | awk 'NR==2 {print $3}')     #usedram
pram=$(free --mega | awk 'NR==2 {printf("%.2f"), $3/$2*100}')   #percentage of the used memory
TOTAL_MEMORY=$(vmstat -s | awk '{if(NR == 1) print$1}')
USED_MEMORY=$(vmstat -s | awk 'NR==1 {print$1}')
USED_MEMORY_PERCENT=$(expr $USED_MEMORY \* 100 / $TOTAL_MEMORY)
cpuload=$(echo 100 - $(mpstat | awk 'NR==4 {print$NF}') | bc)
lastboot=$(who -b | awk '{print$3,$4}')
TCP=$(netstat -nat | grep 'ESTABLISHED' | wc -l)
ULOG=$(users | wc -l)
IP=$(hostname -I)
mac=$(ip address | grep link/ether | awk '{print $(NF -2)}')
CMD=$(journalctl _COMM=sudo | grep COMMAND | wc -l)


*************************************************************************************
wall "
	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: `expr $USED_MEMORY / 1024`/`expr $TOTAL_MEMORY / 1024`MB ($USED_MEMORY_PERCENT%%)`
	#CPU load: $cpuload %
	#Last boot: $lastboot
	#LVM use: yes
	#Connexions TCP: $TCP ESTABLISHED
	#User log: $ULOG
	#Network: IP $IP ($MAC)
	#Sudo: $CMD cmd"


*************************************************************************************
