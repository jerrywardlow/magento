#!/bin/sh

MYSQL_ROOT_PW='rootpw'
DB_NAME='magento'
DB_USER='magento'
DB_PASSWORD='magento'

MAGENTO_PUBLIC=$1
MAGENTO_PRIVATE=$2

echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PW" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PW" | sudo debconf-set-selections

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
sudo cp /sync/magento.conf /etc/apache2/sites-available/
sudo a2ensite magento.conf

# Build out MySQL database and user
sudo mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
                                       GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
                                       FLUSH PRIVILEGES;"

# Pull magento
wget https://github.com/magento-2/magento-2-community/archive/master.tar.gz
sudo mkdir -p /var/www/magento
sudo tar --strip-components=1 -xzvf master.tar.gz -C /var/www/magento

# Create composer credentials for Magento
sudo mkdir -p /root/.composer
sudo cp /sync/auth.json /root/.composer/auth.json
sudo sed -i "s/MAGENTO_PUBLIC/${MAGENTO_PUBLIC}/g" /root/.composer/auth.json
sudo sed -i "s/MAGENTO_PRIVATE/${MAGENTO_PRIVATE}/g" /root/.composer/auth.json
