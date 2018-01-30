FROM nxswesolowski/ubuntu-apache
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts
ADD .docker/supervisor /etc/supervisor/conf.d

RUN apt-get -y --force-yes install mysql-server-5.6 \
&& rm -rf /etc/mysql/mysql.conf.d/*

ADD .docker/mysql/conf.d /etc/mysql/conf.d

RUN rm -rf /var/lib/mysql/ib_logfile* \
&& /opt/docker/scripts/config-mysql.sh \
&& mkdir /var/www/log

EXPOSE 3306
CMD ["supervisord", "-n"]