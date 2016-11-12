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
             php7.0-xml \
             php7.0-zip \
             libapache2-mod-php7.0 \
             composer

sudo a2enmod php7.0
