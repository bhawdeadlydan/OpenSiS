sudo apt-get update
sudo apt-get install apache2
sudo apt-get install mysql-server 
sudo apt-get install php5
sudo apt-get install libapache2-mod-php5
sudo apt-get install php5-mysql
 
wget http://nchc.dl.sourceforge.net/project/opensis-ce/opensis5.1.zip
sudo apt-get install unzip
unzip opensis5.1.zip
sudo cp -R  ~/opensis /var/www/
chmod -R  777 /var/www/opensis/
sudo service apache2 restart

Open Browser [http://localhost/opensis/install/index.php] and proceed with installation.
