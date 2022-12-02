# KNOWLEDGE
## ->WEB SERVER
Web servers are software or hardware (or both together) that stores and delivers content to a web browser at a basic level. The servers communicate with browsers using Hypertext Transfer Protocol (HTTP). Web servers can also support SMTP (Simple Mail Transfer Protocol) and FTP (File Transfer Protocol). 
Web servers are also used for hosting websites and data for web applications. They can host single websites and multiple websites using virtualization.

to sum up, a web server is software that sits and listens on a port for a request via a transport protocol and then sends a response containing the resources

SOME KNOWN WEB SERVER:
* APACHE
* IIS
* LIGHTTPD
* NGINX
* JIGSAW
<p align="center">
<img src="https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/sources/web-server.svg" align="center" width="888" hight="443"/>
</p>

### installing lighttpd
```
sudo apt install lighttpd
```
after the installation you need you allow th port 80 **(default port for http connection)**
```
1-sudo ufw allow http
2-sudo ufw allow 80
```
## ->DATA BASE
A database is an organized collection of structured information, or data, typically stored electronically in a computer system. A database is usually controlled by a database management system (DBMS). Together, the data and the DBMS, along with the applications that are associated with them, are referred to as a database system, often shortened to just database.

<p align="center">
<img src="https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/sources/how-a-dbms-works.png" align="center" width="888" hight="443"/>
</p>

Best Database Management Software
* MongoDB Atlas
* MySQL
* PostgreSQL
* Oracle
* MariaDB

### installing mariadb
```
sudo apt install mariadb-server
```
Start interactive script to remove insecure default settings via
```
sudo mysql_secure_installation
Enter current password for root (enter for none): #Just press Enter (do not confuse database root with system root)
Set root password? [Y/n] n
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```
Log in to the MariaDB console 
```
sudo mariadb
```
Create new database 
```
MariaDB [(none)]> CREATE DATABASE <database-name>;
```
Create new database user and grant them full privileges on the newly-created database 
```
MariaDB [(none)]> GRANT ALL ON <database-name>.* TO '<username-2>'@'localhost' IDENTIFIED BY '<password-2>' WITH GRANT OPTION;
```
Flush the privileges
```
MariaDB [(none)]> FLUSH PRIVILEGES;
```
Exit the MariaDB shell 
```
MariaDB [(none)]> exit
```
Verify whether database user was successfully created by logging in to the MariaDB console
```
mariadb -u <username-2> -p
Enter password: <password-2>
MariaDB [(none)]>
```
Confirm whether database user has access to the database 
```
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
```
Exit the MariaDB shell
```
MariaDB [(none)]> exit
```

### installing php
installing php-cgi && php-mysql
```
sudo apt install php-cgi php-mysql
```
###  Downloading && Configuring WordPress
Download WordPress to /var/www/html
```
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html
```
Extract downloaded content
```
sudo tar -xzvf /var/www/html/latest.tar.gz
```
Remove tarball
```
sudo rm /var/www/html/latest.tar.gz
```
Copy content of /var/www/html/wordpress to /var/www/html
```
sudo cp -r /var/www/html/wordpress/* /var/www/html
```
Remove /var/www/html/wordpress
```
sudo rm -rf /var/www/html/wordpress
```
Create WordPress configuration file from its sample
```
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
```
Configure WordPress to reference previously-created MariaDB database & user via 
```
sudo vi /var/www/html/wp-config.php
```
Replace the below
```
23 define( 'DB_NAME', 'database_name_here' );^M
26 define( 'DB_USER', 'username_here' );^M
29 define( 'DB_PASSWORD', 'password_here' );^M
```
with:
```
23 define( 'DB_NAME', '<database-name>' );^M
26 define( 'DB_USER', '<username-2>' );^M
29 define( 'DB_PASSWORD', '<password-2>' );^M
```
### Configuring Lighttpd
Enable below modules via sudo lighty-enable-mod fastcgi; sudo lighty-enable-mod fastcgi-php; sudo service lighttpd force-reload.
```
 sudo lighty-enable-mod fastcgi
 sudo lighty-enable-mod fastcgi-php
 sudo service lighttpd force-reload
```



## File Transfer Protocol (FTP)
### Installing & Configuring FTP
Install FTP via sudo apt install vsftpd.
```
sudo apt install vsftpd
```
Allow incoming connections using Port 21 via sudo ufw allow 21.
```
sudo ufw allow 21
```
Configure vsftpd via sudo vi /etc/vsftpd.conf.
```
sudo vi /etc/vsftpd.conf
```
To enable any form of FTP write command, uncomment below line:
```
31 #write_enable=YES
```
To set root folder for FTP-connected user to /home/<username>/ftp, add below lines:
```
sudo mkdir /home/<username>/ftp
sudo mkdir /home/<username>/ftp/files
sudo chown nobody:nogroup /home/<username>/ftp
sudo chmod a-w /home/<username>/ftp
<~~~>
user_sub_token=$USER
local_root=/home/$USER/ftp
<~~~>
 ```
To prevent user from accessing files or using commands outside the directory tree, uncomment below line:
```
114 #chroot_local_user=YES
 ```
To whitelist FTP, add below lines:
```
 sudo vi /etc/vsftpd.userlist
 echo <username> | sudo tee -a /etc/vsftpd.userlist
<~~~>
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
<~~~>
 ```
### Connecting to Server via FTP
FTP into your virtual machine via ftp <ip-address>.
```
ftp <ip-address>
 ```
Terminate FTP session at any time:
 ```
 CTRL + D
 ```
