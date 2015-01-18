#!/bin/bash

apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5 php5-cli php5-xmlrpc php5-ldap php5-gd php5-mysql php5-mcrypt mysql-server openssh-server unzip sudo patch

echo "root:root" | chpasswd

mkdir -p /var/www/i-doit
unzip -qq /idoit-src/idoit-open-1.4.7.zip -d /var/www/i-doit
cd /var/www/i-doit 
chown -R www-data:www-data .
chmod +x idoit-rights.sh
./idoit-rights.sh set
echo "Set mysql password"
/etc/init.d/mysql start
/usr/bin/mysqladmin -uroot password 'secret'
echo ""
echo "Install i-doit"
echo "This could take a moment"
#You have to change into the setup folder - or update the install script...
cd setup
./install.sh -m idoit_data -s idoit_system -p secret -a admin -n "idoit-open" -q
if [ $? == 0 ]; then
	echo "successfully installed idoit"
	echo ""
	echo "Now setting up recommended configs"
	echo ""
	/idoit-src/set_idoit_configs.sh
	echo ""
	echo "Removing install files"
	mv /idoit-src/run.sh /run.sh
	rm -rf /idoit-src
	exit 0
fi

# We never should end here ;-)
exit 1