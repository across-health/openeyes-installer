FROM ubuntu:trusty
MAINTAINER Dave Thompson "davethompson21@gmail.com"

RUN apt-get -y update
RUN apt-get -y -q install git-core
RUN apt-get -y install libapache2-mod-php5 php5-cli php5-mysql php5-ldap php5-curl php5-xsl
RUN apt-get -y install wkhtmltopdf
RUN apt-get -y install mysql-server

RUN service mysql start && mysql -uroot -e "create database openeyes;"
RUN service mysql start && mysql -uroot -e "create user 'openeyes'@'localhost' identified by 'oe_test'; grant all privileges on openeyes.* to 'openeyes'@'localhost' identified by 'oe_test'; flush privileges;"

RUN git clone --depth=1 https://github.com/openeyes/OpenEyes.git /var/www/openeyes

RUN chmod 777 /var/www/openeyes/protected
RUN mkdir /var/www/openeyes/protected/runtime && chmod 777 /var/www/openeyes/protected/runtime
RUN chmod 777 /var/www/openeyes/assets
RUN chmod 777 /var/www/openeyes/protected/files
RUN cp /var/www/openeyes/index.example.php /var/www/openeyes/index.php
RUN cp /var/www/openeyes/.htaccess.sample /var/www/openeyes/.htaccess
RUN mkdir /var/www/openeyes/protected/config/local
RUN cp /var/www/openeyes/protected/config/local.sample/common.sample.php /var/www/openeyes/protected/config/local/common.php

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/var/www/openeyes
RUN cd /var/www/openeyes && ./composer.phar install --no-dev

RUN service mysql start && /var/www/openeyes/protected/yiic migrate --interactive=0
RUN service mysql start && /var/www/openeyes/protected/yiic migratemodules --interactive=0

COPY docker/vhost.conf /etc/apache2/sites-available/openeyes.conf
RUN a2enmod rewrite
RUN a2dissite 000-default
RUN a2ensite openeyes

RUN apt-get -y install supervisor
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
