#!/bin/sh


# Apache
yum install -y httpd

systemctl start httpd.service

systemctl enable httpd.service


# MariaDB
yum install -y mariadb-server mariadb

systemctl start mariadb.service

systemctl enable mariadb.service


# PHP
# pdo_mysql DOM simplexml iconv mcrypt curl hash SOAP GD
