#!/bin/bash

docker stop mysql
docker rm mysql
docker run --name mysql -d -p 80:80 -p 2222:22 -p 3306:3306 nxsjung/ubuntu-apache-mysql:5.7
