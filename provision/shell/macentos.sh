#!/bin/sh

MYSQL_ROOT_PW='ROOTpw123#!'
DB_NAME='magento'
DB_USER='magento'
DB_PASSWORD='MAGento123#!'

ADMIN_USER='admin'
ADMIN_PASSWORD='ADMINpassword123#!'

MAGENTO_PUBLIC=$1
MAGENTO_PRIVATE=$2

BASE_URL=$3

# IUS Repository
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum update -y
yum install -y wget

# Apache
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
mkdir -p /var/www/magento
mkdir -p /etc/httpd/sites-available
mkdir -p /etc/httpd/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" | sudo tee --append  /etc/httpd/conf/httpd.conf
cp /sync/magento.conf /etc/httpd/sites-available/
ln -s /etc/httpd/sites-available/magento.conf /etc/httpd/sites-enabled/magento.conf
usermod -aG apache $USER
chgrp -R apache /var/www/magento

# MySQL
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
rpm -ivh mysql57-community-release-el7-9.noarch.rpm
yum update -y
yum install -y mysql-community-server
systemctl start mysqld.service
systemctl enable mysqld.service
TEMP_ROOT_PW=`sudo grep 'temporary password' /var/log/mysqld.log | awk '{ print $NF }'`
mysqladmin -uroot -p$TEMP_ROOT_PW password $MYSQL_ROOT_PW

# PHP
yum install -y \
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

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

# Build database
mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
                                  GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
                                  FLUSH PRIVILEGES;"

# Pull magento
wget https://github.com/magento-2/magento-2-community/archive/master.tar.gz
tar --strip-components=1 -xzvf master.tar.gz -C /var/www/magento

# Create composer credentials for Magento
# Careful with permissions/locations/user here RE: composer install
mkdir -p ~/.composer
cp /sync/auth.json ~/.composer/auth.json
sed -i "s/MAGENTO_PUBLIC/${MAGENTO_PUBLIC}/g" ~/.composer/auth.json
sed -i "s/MAGENTO_PRIVATE/${MAGENTO_PRIVATE}/g" ~/.composer/auth.json

# Install via Composer
composer install -d /var/www/magento

# File permissions

# Run Magento installer
sudo php /var/www/magento/bin/magento setup:install --base-url=http://$BASE_URL/ \
    --db-host=localhost --db-name=$DB_NAME --db-user=$DB_USER --db-password=$DB_PASSWORD \
    --admin-firstname=Magento --admin-lastname=Admin --admin-email=admin@example.com \
    --admin-user=$ADMIN_USER --admin-password=$ADMIN_PASSWORD --language=en_US \
    --currency=USD --timezone=America/Los_Angeles --use-rewrites=1
