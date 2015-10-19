#!/bin/bash

apt-get -y update
apt-get -y -q install git-core
apt-get -y install libapache2-mod-php5 php5-cli php5-mysql php5-ldap php5-curl php5-xsl
apt-get -y install wkhtmltopdf
apt-get -y install wget
