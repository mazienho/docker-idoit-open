#!/bin/bash

instfile=/idoit-src/idoit-open-1.4.7.zip
updtfile=/idoit-src/idoit-open-1.4.8-update.zip
aptwget=0

apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5 php5-cli php5-xmlrpc php5-ldap php5-gd php5-mysql php5-mcrypt php5-snmp mysql-server openssh-server unzip sudo patch

echo "root:root" | chpasswd

mkdir -p /var/www/i-doit
if [ ! -f $instfile ]; then
	aptwget=1
	apt-get install -y wget
	wget http://sourceforge.net/projects/i-doit/files/i-doit/1.4.7/idoit-open-1.4.7.zip -O $instfile
fi
#	unzip -qq /idoit-src/idoit-open-1.4.7.zip -d /var/www/i-doit
	unzip -qq $instfile -d /var/www/i-doit

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
fi

#Updates
echo ""
echo "Installing Updates"
if [ ! -f $updtfile ]; then
	if [ $aptwget == 0 ]; then
		apt-get install -y wget
	fi
	wget http://sourceforge.net/projects/i-doit/files/i-doit/1.4.8/idoit-open-1.4.8-update.zip -O $updtfile
	unzip -qq -uo $updtfile -d /var/www/i-doit
	echo "Update zip file extracted. Open <i-doit-IP/updates> in webbrowser and follow instructions."

fi
echo "Removing install files"
mv /idoit-src/run.sh /run.sh
rm -rf /idoit-src

exit 0