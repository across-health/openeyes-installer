#!/bin/bash

apt-get -y install mysql-server
service mysql start
mysql -uroot -e "create database openeyes;"
mysql -uroot -e "create user 'openeyes'@'localhost' identified by 'oe_test'; grant all privileges on openeyes.* to 'openeyes'@'localhost' identified by 'oe_test'; flush privileges;"