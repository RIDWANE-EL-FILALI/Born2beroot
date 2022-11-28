# GENERAL KNOWLEDGE
## INTRODUCTION
   In this project you will create your first virtual machine in VirtualBox under some instructions. at the end you'll implement some strict rules on your OS

## WHAT IS A VIRTUAL MACHINE ?
   A Virtual Machine (VM) is a compute resource that uses software instead of a physical computer to run programs and deploy apps. One or more virtual “guest” machines run on a physical “host” machine.  Each virtual machine runs its own operating system and functions separately from the other VMs, even when they are all running on the same host. This means that, for example, a virtual MacOS virtual machine can run on a physical PC.
    and all that can be accomplished with the help of hypervisor.
    The hypervisor is responsible for isolating the VM resources from the system hardware and making the necessary implementations so that the VM can use these resources.
The devices that provide the hardware resources are called host machines or hosts. The different virtual machines that can be assigned to a host are called guests or guest machines. The hypervisor uses a part of the host machine's CPU, storage, etc., and distributes them among the different VMs.

## WHAT IS LVM ?
  LVM(logical volume manager) allows the creation of group's of disks or partitions that can be assembled into a single (or multiple) filesystems:
  * Can be used for nearly any mount point exept /boot
  * Flexibility : allows for resizing of volumes
  * snapshots:allows for point in time copie of your logical volume
<p align="center">
<img src="https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/sources/lvm-layout-2759342820" align="center" width="888" hight="443"/>
</p>

## APPARMOR VS SELinux ?
  * AppArmor provides Mandatory Access Control (MAC) security. In fact, AppAmor allows the system administrator to restrict the actions that processes can perform. For example, if an installed application can take photos by accessing the camera application, but the administrator denies this privilege, the application will not be able to access the camera application. If a vulnerability occurs (some of the restricted tasks are performed), AppArmor blocks the application so that the damage does not spread to the rest of the system.
In AppArmor, processes are restricted by profiles. Profiles can work in complain-mode and in enforce-mode. In enforce mode, AppArmor prohibits applications from performing restricted tasks. In complain-mode, AppArmor allows applications to do these tasks, but creates a registry entry to display the complaint,
comes pre-installed in debian distribution.
  * Security-Enhanced Linux (SELinux) is a security architecture for Linux® systems that allows administrators to have more control over who can access the system. It was originally developed by the United States National Security Agency (NSA) as a series of patches to the Linux kernel using Linux Security Modules (LSM), comes pre-installed in RedHat-based Linux Distributions.

## WHAT IS THE DIFFERENCE BETWEEN APT & APTITUDE ?
  * Apt(advanced package tool)  which is a tool that uses dpkg, can be used to install all the necessary dependencies when installing a program. So now we can install a useful program with a single command.
  * Aptitude is the same as apt juste with a graphical interface and a better control over dependecies when installing a programe.

## WHAT IS SSH ?
  SSH or Secure Shell is a remote administration protocol that allows users to control and modify their servers over the Internet thanks to an authentication mechanism. Provides a mechanism to authenticate a user remotely, transfer data from the client to the host, and return a response to the request made by the client.
SSH was created as an alternative to Telnet, which does not encrypt the information that is sent. SSH uses encryption techniques to ensure that all client-to-host and host-to-client communications are done in encrypted form. One of the advantages of SSH is that a user using Linux or MacOS can use SSH on their server to communicate with it remotely through their computer's terminal. Once authenticated, that user will be able to use the terminal to work on the server.
 
Connect to a server using :
```
ssh {username}@{IP_ADRESS_OF_THE_SERVER} -p {port number}
```

There are three different techniques that SSH uses to encrypt:

  * Symmetric encryption: a method that uses the same secret key for both encryption and decryption of a message, for both the client and the host. Anyone who knows the password can access the message that has been transmitted.
  * Asymmetric encryption: uses two separate keys for encryption and decryption. These are known as the public key and the private key. Together, they form the public-private key pair.
  * Hashing: another form of cryptography used by SSH. Hash functions are made in a way that they don't need to be decrypted. If a client has the correct input, they can create a cryptographic hash and SSH will check if both hashes are the same.


## WHAT IS A FIREWALL ?
  A firewall is a system that is designed to prevent unauthorized access from entering a private network, so the purpose of the firewall is to create a safety barrier between private network(you) and th public netwok(the internet) and ther is two types 
  * Host-based firewall: software firewall that is installed on a computer, and it protects that computer only.
  * Network-based firewall: combination of hardware and software, and it protects the entire private network.
  
## WHAT IS UFW ?
  UFW (Uncomplicated Firewall) is a software application responsible for ensuring that the system administrator can manage iptables in a simple way. Since it is very difficult to work with iptables, UFW provides us with an interface to modify the firewall of our device (netfilter) without compromising security. Once we have UFW installed, we can choose which ports we want to allow connections, and which ports we want to close. This will also be very useful with SSH, greatly improving all security related to communications between devices.
  
## WHAT IS CRON ?
  Linux task manager that allows us to execute commands at a certain time. We can automate some tasks just by telling cron what command we want to run at a specific time.
  to check how cron work just use the command :
  ```
  cat /etc/crontab
  ```
  
## WHAT IS WALL ?
  command used by the root user to send a message to all users currently connected to the server. If the system administrator wants to alert about a major server change that could cause users to log out, the root user could alert them with wall.
  
# INSTALLATION
  In my case,i've chosen Debian as my os of choice
  you can install it [here](https://www.debian.org/download)
  
## SUDO
  ### installing sudo :
  * you need first to switch to root using the su command, by default using su alone will move you to the root
  ```
  $su
  password: enter the root password
  #
  ```
  * install sudo:
  ```
  #apt install sudo
  ```
  ### add the user to sudo group :
  ```
  1 - adduser <username> sudo(the name of the group)
  2 - usermode -aG sudo <username>
  ```
  -a : Add the user to the supplementary group(s). Use only with the -G option.
  
  -G : A list of supplementary groups which the user is also a member of. Each group is separated from the next
       by a comma, with no intervening whitespace. The groups must exist.
       If the user is currently a member of a group which is not listed, the user will be removed from the
       group. This behaviour can be changed via the -a option, which appends the user to the current
       supplementary group list.
  * you can check if the user has been added to the specified group:
  ```
  getent group sudo
  ```
  getent is a Linux command that helps the user to get the entries in a number of important text files called databases. This includes the passwd and the group of databases which stores the user information. Hence getent is a common way to look up in user details on Linux. Since getent uses the same name of service as the system, getent will be going to show all information, including that gained from the network information sources such as LDAP. The databases it usually searches in are: ahosts, ahostsv4, ahostsv6, aliases, ethers (Ethernet addresses), group, gshadow, hosts, netgroup, networks, passwd, protocols, rpc, services, and shadow.
  * Give privilege as su :
  ```
  $ sudo visudo
  ```
  * add this line in th file :
  ```
  <username> ALL=(ALL) ALL
  THE USER CAN USE ALL COMMANDS WITH SUDO BEING ANY USER
  ```
  ### running some commands :
  * apt update downloads package information from all configured sources (i.e. the sources configured inside /etc/apt/sources.list). This is how your system knows which packages are available for upgrade, and where to retrieve that software.
  ```
  sudo apt update
  ```
  * apt upgrade can then act on this information and upgrade all installed packages to their latest versions. This command will only upgrade packages that are already installed; it won’t install new packages unless they are required for resolving dependencies. apt upgrade also won’t remove any packages. If a package must be removed to complete an upgrade, the command will simply skip that upgrade and leave your current packages intact.
  ```
  sudo apt upgrade
  ```
  ### configuring sudo :
  * configuring sudo in ```/etc/sudoers```
  ```
  $ sudo vim /etc/sudoers
  ```
  * limit authentication using sudo to 3 tries :
  ```
  Defaults        passwd_tries=3
  ```
  * to add a message of your choice add :
  ```
  Defaults        badpass_message=" YOU SUCK ! , TRY AGAIN"
  ```
  * to log all sudo commands to :
  ```
  Defaults        logfile="/var/log/sudo/sudo.log"
  Defaults        log_input,log_output
  ```
  * to require TTY :
  If set, sudo will only run when the user is logged in to a real tty. When this flag is set, sudo can only be run from a login session and not via other means such as cron(8) or cgi-bin scripts. This flag is off by default.
  ```
  Defaults        requiretty
  ```
  * set sudo paths to: for security reasons
  ```
   Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
  ```
## SSH
### installing ssh 
* install ssh server :
```
sudo apt install openssh-server
```
### configuring ssh 
* edit the configuration file
```
sudo vim /etc/ssh/sshd_config
```
* uncomment and change the port rule
```
#Port 22 ====> Port 4242
```
* disable ssh login as root
```
#PermitRootLogin prohibit-password   =====>   PermitRootLogin no
```
* check ssh status 
```
1 - sudo service status ssh
2 - systemctl ssh status
```
* restart the ssh service
```
systemctl restart sshd
```
ssh[d] the d stands for deamons and its services that run on the background with no user interaction

* connecting to a server using
```
ssh <username>@<ip-address> -p 4242
```
* terminate the session
```
1 - logout
2 - exit
```
## UFW
### installing && configuration of ufw
* installing ufw
```
sudo apt install ufw
```
☠️ be carefull if you are configuring over ssh, you may wish to allow ssh before enabling the firewall. if you connection gets interrupted before allowing ssh you may be locked out of the system.
* enable ufw
```
sudo ufw enable
```
* set the defaults 
```
ufw default deny incoming
ufw default allow outgoing
```
* allow incoming connections using Port 4242
```
sudo ufw allow 4242/tcp
```
* check ufw status
```
sudo ufw status
```
* check ufw status with numberd rules for better comtrol
```
sudo ufw status numbered
```
* delete a rule
```
ufw delete [number of the rule]
```

## user management
### the password policy
* enter the configuration file 
```
sudo vim /etc/login.defs
```
* configuring password age policy
```
PASS_MAX_DAYS  99999  =====>   30
PASS_MIN_DAYS  0      =====>   2
PASS_WAN_AGE   7      =====>   7

#  PASS_MAX_DAYS	Maximum number of days a password may be used.
#	PASS_MIN_DAYS	Minimum number of days allowed between password changes.
#	PASS_WARN_AGE	Number of days warning given before a password expires.
```
* for the already existing users(<username42> && root)
```
sudo chage -M 30 <username>
sudo chage -m 2  <username>
sudo chage -W 7  <username>
```
chage - change user password expiry information
* check password expiry date for user
```
chage -l <username>
```
### password strengh
* Install password quality verification library:
```
sudo apt install libpam-pwquality
```
* check the macros for password strenght policy 
```
cat /etc/security/pwquality.conf
```
* configure password strenght 
```
sudo vim /etc/pam.d/common-pawwsord
```
* require minimum lenght of the password
```
minlen=10
```
* require at least an uppercase and a numeric character
```
ucredit=-1  dcredit=-1
```
* to set a maximum of 3 consecutive identical characters
```
maxrepeat=3
```
* to reject the password if it contains <username> in some form
```
reject_username
```
* to set the number of changes required in the new password from the old password to 7
```
difok=7
```   
* To implement the same policy on root
```
enforce_for_root
```
### change the password
```
passwd <username>
```
## creating a new user & groups
```
sudo adduser <username> ---> create new user
getent passwd <username> ---> check if the user was successfully created
sudo userdel <username> --->delete a user

   
sudo groupadd <groupname>   ---->  create new group
sudo adduser <username> <groupname>   ---->  add a user to a group
sudo usermod -aG <groupname> <username>  ----^
getent group <groupname>  --->  check group users
sudo groupdel <username> --->delete a group
```
## cron
* configure cron as root
```
sudo crontab -u root -e
```
* to schedule a shell script to run every 10 minutes
```
*/10 * * * * bash /path/script
```
* check cron scheduled jobs for a user
```
sudo crontab -u root -l
```
---
# Monitoring
   you'll create a script in bash, At server startup, the script will display some information (listed below) on all ter- minals every 10 minutes (take a look at wall). The banner is optional. No error must be visible. Your script must always be able to display the following information:
* The architecture of your operating system and its kernel version.
* The number of physical processors.
* The number of virtual processors.
* The current available RAM on your server and its utilization rate as a percentage.
* The current available memory on your server and its utilization rate as a percentage.
* The current utilization rate of your processors as a percentage.
* The date and time of the last reboot.
* Whether LVM is active or not.
* The number of active connections.
* The number of users using the server.
* The IPv4 address of your server and its MAC (Media Access Control) address.
* The number of commands executed with the sudo program.
   
[check mine here](https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/monitoring.sh)


















