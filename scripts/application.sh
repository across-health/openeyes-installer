#!/bin/bash

git clone --depth=1 https://github.com/openeyes/OpenEyes.git /var/www/openeyes
chmod 777 /var/www/openeyes/protected
mkdir /var/www/openeyes/protected/runtime && chmod 777 /var/www/openeyes/protected/runtime
chmod 777 /var/www/openeyes/assets
chmod 777 /var/www/openeyes/protected/files
cp /var/www/openeyes/index.example.php /var/www/openeyes/index.php
cp /var/www/openeyes/.htaccess.sample /var/www/openeyes/.htaccess
mkdir /var/www/openeyes/protected/config/local
cp /src/common.php /var/www/openeyes/protected/config/local/common.php

php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/var/www/openeyes
cd /var/www/openeyes && ./composer.phar install --no-dev

service mysql start
echo "Creating test data..."
mysql -uroot -D openeyes < /src/openeyes_testdata.sql
echo "Finished creating test data..."
/var/www/openeyes/protected/yiic migrate --interactive=0
/var/www/openeyes/protected/yiic migratemodules --interactive=0