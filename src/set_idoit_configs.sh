#!/bin/bash

#Script to modify mysql, apache settings for idoit
#executed in idoit-install script

#Check if patch file(s) exists

if [ -f /src/my-cnf.patch ]; then
	patch /etc/mysql/my.cnf < /src/my-cnf.patch
	echo "MySQL config patched"
else
	echo "No mysql patch file found. Modify it manually."
fi

if [ -f /src/php-ini.patch ]; then
	patch /etc/php5/apache2/php.ini < /src/php-ini.patch
	echo "MySQL config patched"
else
	echo "No php patch file found. Modify it manually."
fi

exit 0