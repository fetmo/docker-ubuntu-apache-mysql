#!/bin/bash

docker run --name test2 -d -p 80:80 -p 2222:22 -p 3306:3306 -p 9000:9000  nxswesolowski/ubuntu-apache-mysql