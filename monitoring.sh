#!/bin/bash

#Make sure to install sysstat via `sudo apt install sysstat`
#Make sure to install bc via `sudo apt install bc`
#Make sure to write the path to the sudo log files you created in last line instead of `/var/log/sudo/sudo_logs`

THREADS=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 3) print $NF}')
CORES=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 4) print $NF}')
SOCKETS=$(lscpu | egrep 'Thread|Core|Socket|^CPU' | awk '{if(NR == 5) print $NF}')

TOTAL_MEMORY=$(vmstat -s | awk '{if(NR == 1) print$1}')
USED_MEMORY=$(vmstat -s | awk '{if(NR == 2) print$1}')
USED_MEMORY_PERCENT=$(expr $USED_MEMORY \* 100 / $TOTAL_MEMORY)

CPU_IDLE=$(mpstat | awk 'END{print $NF}')

TOTAL_DISK_SIZE=$(df -h --total --output=size| awk 'END{print$NF}')
USED_DISK_SIZE=$(df -h --total --output=used | awk 'END{print$NF}')
USED_DISK_PERCENT=$(df -h --total | awk 'END{print$(NF - 1)}')

printf "#Architecture: `uname -a` \n"*
printf "#CPU physical: `nproc` \n"*
printf "#vCPU: `expr $THREADS \* $CORES \* $SOCKETS` \n"*
printf "#Memory Usage: `expr $USED_MEMORY / 1024`/`expr $TOTAL_MEMORY / 1024`MB ($USED_MEMORY_PERCENT%%) \n"
printf "#Disk Usage: $USED_DISK_SIZE/$TOTAL_DISK_SIZE ($USED_DISK_PERCENT%)\n"
printf "#CPU Load: `echo 100 - $CPU_IDLE | bc`%% \n"
printf "#Last Boot: `who -b | awk '{print $(NF - 1), $NF}'` \n"
printf "#LVM use: yes \n"
printf "#Connexions TCP: `netstat -ant | grep ESTABLISHED | wc -l` ESTABLISHED \n"
printf "#User Log: `who | wc -l` \n"
printf "#Network: IP `hostname -I` (`ip addr | grep link/ether | awk '{print $(NF -2)}'`) \n"
printf "#Sudo: `cat /var/log/sudo/sudo_logs | grep COMMAND | wc -l` cmd" 




#!/bin/bash
arc=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvmt=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)
#You need to install net tools for the next step [$ sudo apt install net-tools]
ctcp=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l) # journalctl should be running as sudo but our script is running as root so we don't need in sudo here
wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lb
	#LVM use: $lvmu
	#Connexions TCP: $ctcp ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" # broadcast our system information on all terminals
  
  
  ```
  
                                             ##################################
                                           #    Part one: Evaluation Q&A    #
                                           ##################################
!GOOGLE IT IF YOU WANT MORE!

Q: Why Debian?
A: It's easier to install and configure than CentOS (and i haven't use CentOS befoe)

Q: What is virtual machine?
A: A Virtual Machine (VM) is a compute resource that uses software instead of a physical computer to run programs and deploy 
apps. Each virtual machine runs its own operating system and functions separately from the other VMs, even when they are all
running on the same host. For example, you can run a virtual MacOS machine on a physical PC. 

Q: What it's purpose?
A: VMs may be deployed to accommodate different levels of processing power needs, to run software that requires a different
operating system, or to test applications in a safe, sandboxed environment. 

Q: How does it works?
A: VM working through "Virtualization" technology. Virtualization uses software to simulate virtual hardware that allows 
VMs to run on a single host machine.

Q: Diff between aptitude and apt?
A: Aptitude is a high-level package manager while APT is lower-level package manager which can be used by other 
higher-level package managers
(read more: https://www.tecmint.com/difference-between-apt-and-aptitude/)

Q: What is AppArmor?
A: AppArmor ("Application Armor") is a Linux kernel security module that allows the system administrator to restrict programs'
capabilities with per-program profiles.
(read more: https://en.wikipedia.org/wiki/AppArmor)

Q: What is SSH?
A: SSH, also known as Secure Shell or Secure Socket Shell, is a network protocol that gives users, particularly system 
administrators, a secure way to access a computer over an unsecured network.
(read more: https://searchsecurity.techtarget.com/definition/Secure-Shell)

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
| You have to create a new user here.        |
| $ sudo adduser username                    | <- creating new user (yes (no))
| $ sudo chage -l username                   | <- Verify password expire info for new user
| $ sudo adduser username sudo               |
| $ sudo adduser username user42             | <- assign new user to sudo and user42 groups
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

Q: How your script works?
A: ... README.md

                                           ##################################
                                           #    Part two: What to check?    #
                                           ##################################
|***************************************|
| 1) lsblk                              1 <- Check partitions
| 2) sudo aa-status                     2 <- AppArmor status
| 3) getent group sudo                  3 <- sudo group users
| 4) getent group user42                4 <- user42 group users
| 5) sudo service ssh status            5 <- ssh status, yep
| 6) sudo ufw status                    6 <- ufw status
| 7) ssh username@ipadress -p 4242      7 <- connect to VM from your host (physical) machine via SSH
| 8) nano /etc/sudoers.d/<filename>     8 <- yes, sudo config file. You can $ ls /etc/sudoers.d first
| 9) nano /etc/login.defs               9 <- password expire policy
| 10) nano /etc/pam.d/common-password  10 <- password policy
| 11) sudo crontab -l                  11 <- cron schedule
|***************************************|


I think this one need an addition to make it more easy to pass evaluation. So, here we are on our checklist and his commands.

How to change hostname?
[$sudo nano /etc/hostname]

Where is sudo logs in /var/log/sudo?
[$cd /var/log/sudo/00/00 && ls]
You will see a lot of directories with names like 01 2B 9S 4D etc. They contain the logs we need.
[$ sudo apt update]
[$ ls]
Now you see that we have a new directory here.
[$ cd <nameofnewdirectory> && ls]
[$ cat log] <- Input log
[$ cat ttyout] <- Output log

How to add and remove port 8080 in UFW?
[$ sudo ufw allow 8080] <- allow
[$ sudo ufw status] <- check
[$ sudo ufw deny 8080] <- deny (yes yes)

How to run script every 30 seconds?
[$ sudo crontab -e]
Remove or commit previous cron "schedule" and add next lines in crontab file
|*************************************************|
| */1 * * * * /path/to/monitoring.sh              |
| */1 * * * * sleep 30s && /path/to/monitoring.sh |
|*************************************************|
To stop script running on boot you just need to remove or commit
|********************************|
| @reboot /path/to/monitoring.sh |
|********************************|
line in crontab file.
```
