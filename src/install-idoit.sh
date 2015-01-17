#!/bin/bash

apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5 php5-cli php5-xmlrpc php5-ldap php5-gd php5-mysql mysql-server openssh-server unzip sudo	

mkdir -p /var/www/i-doit
unzip -qq /idoit-src/idoit-open-1.4.7.zip -d /var/www/i-doit
cd /var/www/i-doit 
chown -R www-data:www-data .
chmod +x idoit-rights.sh
./idoit-rights.sh set
echo "Set mysql password"
/etc/init.d/mysql start
echo "now wait 10s"
sleep 10s
/etc/init.d/apache2 start
sleep 10s
/usr/bin/mysqladmin -uroot password 'secret'
echo "Install i-doit"
#You have to change into the setup folder - or update the install script...
cd setup
./install.sh -m idoit_data -s idoit_system -p secret -a admin -n "idoit-open" -q
if [ $? == 0 ]; then
	echo "successfully installed idoit"
	echo "Now setting up recommended configs"
	# /idoit-src/set_idoit_configs.sh

	#mv /idoit-src/run.sh /run.sh
	#rm -rf /idoit-src
	exit 0
fi

# We never should end here ;-)
exit 1