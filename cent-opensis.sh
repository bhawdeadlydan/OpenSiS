#!/bin/bash
#Script made for LAMP with OpenSiS
#Author: Vinod.N K
#Usage: Apache, Mysql, PhP & OpenSiS
#Distro : Linux -Centos, Rhel, and any fedora

# Update yum repos.and install development tools
echo "Starting installation of LAMP..."
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install screen -y

# EPEL & Remi-Repo for mysql and php
echo "Installing the Epel & Remi Repo..."
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm && rpm -Uvh epel-release-latest-6.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/remi.repo

# Update with new repo
sudo yum --enablerepo=remi,remi-php56 update -y && sudo yum --enablerepo=remi,remi-php56 upgrade -y
sudo yum install openssl-devel zlib-devel pcre* -y

# Apache Installtion 
sudo yum install httpd -y
echo "<VirtualHost *:80>
     ServerAdmin webmaster@example.com
     ServerName example.com
     ServerAlias example.com
     DocumentRoot /var/www/html/opensis
     ErrorLog /var/logs/httpd/opensis_error.log
     CustomLog /var/logs/httpd/opensis_access.log combined
</VirtualHost>" >> /etc/httpd/conf.d/opensis.conf 

# Please change the Domain name according to you domain
read -p "Please enter your domain name ?: " domain
sed -i 's/example.com/$domain/g' /etc/httpd/conf.d/opensis.conf
sudo service httpd start 

echo "Installing MySQL DB...."
# Install MySQL v5.5
echo "Installing MySQL..."
sudo yum --enablerepo=remi,remi-php56 install mysql mysql-server -y
echo "Configuring MySQL data-dir..."
sudo /etc/init.d/mysqld restart
# password for root user of mysql
read -p "Please Enter the Password for New User root : " pass
sudo /usr/bin/mysqladmin -u root password "$pass"

sleep 2
#ask user about username
read -p "Please enter the username you wish to create : " username
#ask user about allowed hostname
read -p "Please Enter Host To Allow Access Eg: %,ip or hostname : " host
#ask user about password
read -p "Please Enter the Password for New User ($username) : " password
#mysql query that will create new user, grant privileges on database with entered password
mysql -uroot -p"$pass" -e "GRANT ALL PRIVILEGES ON dbname.* TO '$username'@'$host' IDENTIFIED BY '$password'"

sleep 5

# Install PHP v5.5
echo "Installing PHP v5.5..."
sudo yum --enablerepo=remi,remi-php56 install -y php-fpm php-mysql php-pear php-cli php-mcrypt php-gd php-mssql php-pgsql php-mbstring php-xml
sleep 3

# Install git and unzip
echo "Installing git for developer"
sudo yum install -y git unzip
sleep 3

# Install NodeJS v0.10.26for environment
echo "Installing Nodejs v0.10.26..."
cd /usr/src
wget http://nodejs.org/dist/v0.10.26/node-v0.10.26.tar.gz
tar zxf node-v0.10.26.tar.gz
cd node-v0.10.26
sudo ./configure
sudo make
sudo make install
cd ~/
sleep 3

# Restarting Services & Set Up startup when ever rebooted the system we can put in rc.local also but i did it simple
echo "Restarting Services all services..."
sudo service mysqld restart
sudo service httpd restart

sudo chkconfig --levels 235 httpd on
sudo chkconfig --levels 235 mysqld on



