FROM ubuntu:trusty
MAINTAINER Dave Thompson "davethompson21@gmail.com"

ADD base.sh /src/base.sh
ADD mysql.sh /src/mysql.sh
ADD application.sh /src/application.sh
ADD apache.sh /src/apache.sh

# base packages
RUN /src/base.sh
RUN /src/mysql.sh
RUN /src/application.sh

# apache
COPY vhost.conf /etc/apache2/sites-available/openeyes.conf
RUN /src/apache.sh

# supervisor
RUN apt-get -y install supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
