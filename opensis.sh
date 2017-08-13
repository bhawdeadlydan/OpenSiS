sudo apt-get update && sudo apt-get upgrade
sudo apt-get install unzip apache2 mysql-server php libapache2-mod-php php-mysql
sleep 05
wget https://excellmedia.dl.sourceforge.net/project/opensis-ce/opensis6.4.zip
unzip opensis6.4.zip
sudo cp -R  ~/opensis /var/www/
chmod -R  777 /var/www/opensis/
chown -R www-data:www-data /var/www/opensis
sudo service apache2 restart

Open Browser [http://localhost/opensis/install/index.php] and proceed with installation.
