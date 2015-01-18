#!/bin/bash

#Script to modify mysql, apache settings for idoit
#executed in idoit-install script

#Check if patch file(s) exists

phppatch=/idoit-src/php-ini.patch
mypatch=/idoit-src/my-cnf.patch

if [ -f $mypatch ]; then
	patch /etc/mysql/my.cnf < $mypatch
	echo "MySQL config patched"
else
	echo "No mysql patch file found. Modify it manually."
fi

if [ -f $phppatch ]; then
	patch /etc/php5/apache2/php.ini < $phppatch
	echo "MySQL config patched"
else
	echo "No php patch file found. Modify it manually."
fi

exit 0