FROM ubuntu:trusty
MAINTAINER Dave Thompson "davethompson21@gmail.com"

ADD scripts/base.sh /src/base.sh
ADD scripts/mysql.sh /src/mysql.sh
ADD scripts/application.sh /src/application.sh
ADD scripts/apache.sh /src/apache.sh

# base packages
RUN /src/base.sh
RUN /src/mysql.sh
RUN /src/application.sh

# apache
COPY config/vhost.conf /etc/apache2/sites-available/openeyes.conf
RUN /src/apache.sh

# supervisor
RUN apt-get -y install supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
