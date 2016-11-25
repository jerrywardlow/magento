#!/bin/sh

# Repository
yum install -y http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm

yum -y update


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
yum -y install \
    php70u \
    php70u-pdo \
    php70u-mysqlnd \
    php70u-opcache \
    php70u-xml \
    php70u-mcrypt \
    php70u-gd \
    php70u-devel \
    php70u-mysql \
    php70u-intl \
    php70u-mbstring \
    php70u-bcmath \
    php70u-json \
    php70u-iconv
