#!/bin/bash

service ssh start
service apache2 start
service mysql start

touch /tailme
tailf /tailme
