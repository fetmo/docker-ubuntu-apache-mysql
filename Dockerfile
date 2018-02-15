FROM nxswesolowski/ubuntu-apache16
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts
ADD .docker/supervisor /etc/supervisor/conf.d

RUN echo "mysql-server-5.7 mysql-server/root_password password docker" | debconf-set-selections \
&& echo "mysql-server-5.7 mysql-server/root_password_again password docker" | debconf-set-selections \
&& apt-get update --fix-missing \
&& apt-get -y --force-yes install mysql-server-5.7 \
&& rm -rf /etc/mysql/mysql.conf.d/* \
&& chmod +x /opt/docker/scripts/*.sh
#&& echo 'mysql:mysql' | chpasswd
#&& echo "mysql ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN chown -R mysql:mysql /var/lib/mysql

ADD .docker/mysql/conf.d /etc/mysql/conf.d

RUN rm -rf /var/lib/mysql/ib_logfile* \
&& ls -la /var/run/ \
&& /opt/docker/scripts/config-mysql.sh \
&& mkdir /var/www/log

EXPOSE 3306
CMD ["supervisord", "-n"]

#&& sudo -u mysql -H sh -c /opt/docker/scripts/config-mysql.sh \