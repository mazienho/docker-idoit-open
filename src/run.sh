#!/bin/bash

#Start SSH
service ssh start &
wait
#Start mysql
service mysql start &
wait
#/usr/bin/mysqld_safe
#Start apache
#/usr/sbin/apache2ctl start
service apache2 start &
wait