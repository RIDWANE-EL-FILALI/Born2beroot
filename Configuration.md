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
