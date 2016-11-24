#!/bin/sh


# Apache
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service

mkdir -p /etc/httpd/sites-available
mkdir -p /etc/httpd/sites-enabled

echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

mkdir -p /var/www/magento


# MariaDB
yum install -y mariadb-server mariadb

systemctl start mariadb.service

systemctl enable mariadb.service


# PHP
# pdo_mysql DOM simplexml iconv mcrypt curl hash SOAP GD
