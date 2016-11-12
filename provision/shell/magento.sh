#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# Update apt cache
sudo apt-get update

# Install packages
sudo apt-get install -qqy \
             apache2 \
             mysql-server \
             php7.0 \
             php7.0-curl \
             php7.0-gd \
             php7.0-intl \
             php7.0-mbstring \
             php7.0-mcrypt \
             php7.0-mysql \
             php7.0-xml \
             php7.0-zip \
             libapache2-mod-php7.0 \
             composer

sudo a2enmod php7.0

# Clean up base Apache install
sudo a2dissite 000-default.conf
sudo rm -rf /var/www/html

# Pull magento
wget https://github.com/magento-2/magento-2-community/archive/master.tar.gz
sudo mkdir -p /var/www/magento
sudo tar --strip-components=1 -xzvf master.tar.gz -C /var/www/magento

