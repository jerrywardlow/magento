#!/bin/sh

MYSQL_ROOT_PASSWORD="password"
DB_USER="dbuser"
DB_PASSWORD="dbpassword"

set -e

apt-get -qqy update


# Insecure installation of MySQL
export DEBIAN_FRONTEND=noninteractive
apt-get install -qqy mysql-server

# PHP and dependencies (deps pulled from Magento docs)
add-apt-repository -y ppa:ondrej/php
apt-get -qqy update
apt-get install -qqy php7.0 libapache2-mod-php7.0 php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-intl php7.0-xsl php7.0-mbstring php7.0-zip php7.0-bcmath php7.0-iconv
