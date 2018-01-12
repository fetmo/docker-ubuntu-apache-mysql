FROM nxswesolowski/ubuntu-apache-mysql
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN apt-get -y --force-yes install mysql-server-5.6 \
&& rm -rf /etc/mysql/mysql.conf.d/* \
&& chmod +x /opt/docker/scripts/*.sh

ADD .docker/mysql/conf.d /etc/mysql/conf.d

RUN rm -rf /var/lib/mysql/ib_logfile* \
&& /opt/docker/scripts/config-mysql.sh \
&& mkdir /var/www/log

EXPOSE 22 80 3000 3306
CMD ["supervisord", "-n"]