#!/bin/bash

service mysql start

USER="docker"
PASS="docker"
USER2="nexus"
PASS2="nexus"

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Connection established?"
    sleep 5
    mysql -uroot -pdocker -e "status" > /dev/null 2>&1
    RET=$?
done

mysql -uroot -pdocker -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -pdocker -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION"
mysql -uroot -pdocker -e "FLUSH PRIVILEGES"

mysql -uroot -pdocker -e "CREATE USER '$USER2'@'%' IDENTIFIED BY '$PASS2'"
mysql -uroot -pdocker -e "GRANT ALL PRIVILEGES ON *.* TO '$USER2'@'%' WITH GRANT OPTION"
mysql -uroot -pdocker -e "FLUSH PRIVILEGES"

echo "######################################################################"
echo "## MySQL User '$USER' with password '$PASS' successfully created  ##"
echo "## MySQL User '$USER2' with password '$PASS2' successfully created    ##"
echo "######################################################################"

mysqladmin -uroot -pdocker shutdown

service mysql stop