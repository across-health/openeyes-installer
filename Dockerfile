FROM ubuntu:trusty
MAINTAINER Dave Thompson "davethompson21@gmail.com"

ADD scripts/base.sh /src/base.sh
ADD scripts/mysql.sh /src/mysql.sh
ADD scripts/application.sh /src/application.sh
ADD scripts/apache.sh /src/apache.sh

RUN /src/base.sh
RUN /src/mysql.sh
COPY config/mysql.cnf /etc/mysql/conf.d/conf.cnf

COPY config/common.php /src/common.php
COPY config/openeyes_testdata.sql /src/openeyes_testdata.sql
RUN /src/application.sh

COPY config/vhost.conf /etc/apache2/sites-available/openeyes.conf
RUN /src/apache.sh

RUN apt-get -y install supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 3306
CMD ["/usr/bin/supervisord"]
