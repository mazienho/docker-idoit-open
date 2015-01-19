#!/bin/bash

instfile=/idoit-src/idoit-open-1.4.7.zip
updtfile=/idoit-src/idoit-open-1.4.8-update.zip

apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5 php5-cli php5-xmlrpc php5-ldap php5-gd php5-mysql php5-mcrypt php5-snmp mysql-server openssh-server unzip sudo patch

echo "root:root" | chpasswd

mkdir -p /var/www/i-doit
if [ -f $instfile ]; then
	unzip -qq /idoit-src/idoit-open-1.4.7.zip -d /var/www/i-doit
else
	apt-get install -y wget
	wget http://sourceforge.net/projects/i-doit/files/i-doit/1.4.7/idoit-open-1.4.7.zip/download -O $instfile
fi
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
	echo "Removing install files"
	mv /idoit-src/run.sh /run.sh
	rm -rf /idoit-src
	echo ""
fi

#Updates
#echo ""
#if [ -f $updtfile ]; then
#	unzip -qq -uo $updtfile -d /var/www/i-doit
#	echo "Local update zip file found. Open <i-doit-IP/updates> in webbrowser."
#else
#	wget http://sourceforge.net/projects/i-doit/files/i-doit/1.4.8/idoit-open-1.4.8-update.zip -O $updtfile
#	unzip -qq -uo $updtfile -d /var/www/i-doit
#fi

# We never should end here ;-)
exit 1