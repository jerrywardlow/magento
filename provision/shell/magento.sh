#!/bin/sh

MYSQL_ROOT_PW='rootpw'
DB_NAME='magento'
DB_USER='magento'
DB_PASSWORD='magento'

ADMIN_FISTNAME='Magento'
ADMIN_LASTNAME='Admin'
ADMIN_EMAIL='admin@example.com'
ADMIN_USER='admin'
ADMIN_PASSWORD='adminpassword123'

MAGENTO_PUBLIC=$1
MAGENTO_PRIVATE=$2

BASE_URL=$3

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

sudo a2enmod php7.0 rewrite

# Clean up base Apache install
sudo a2dissite 000-default.conf
sudo rm -rf /var/www/html
sudo cp /sync/magento.conf /etc/apache2/sites-available/
sudo a2ensite magento.conf
sudo usermod -aG www-data $USER

# Build out MySQL database and user
sudo mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
sudo mysql -uroot -p$MYSQL_ROOT_PW -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
                                       GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
                                       FLUSH PRIVILEGES;"

# Pull magento
wget https://github.com/magento/magento2/archive/2.1.7.tar.gz
sudo mkdir -p /var/www/magento
sudo chown -R $USER:$USER /var/www/magento
tar --strip-components=1 -xzvf master.tar.gz -C /var/www/magento

# Create composer credentials for Magento
mkdir -p ~/.composer
cp /sync/auth.json ~/.composer/auth.json
sed -i "s/MAGENTO_PUBLIC/${MAGENTO_PUBLIC}/g" ~/.composer/auth.json
sed -i "s/MAGENTO_PRIVATE/${MAGENTO_PRIVATE}/g" ~/.composer/auth.json

# Install via Composer
composer install -d /var/www/magento

# Run Magento installer
sudo php /var/www/magento/bin/magento setup:install --base-url=http://$BASE_URL/ \
                                                    --db-host=localhost \
                                                    --db-name=$DB_NAME \
                                                    --db-user=$DB_USER \
                                                    --db-password=$DB_PASSWORD \
                                                    --admin-firstname=$ADMIN_FIRSTNAME \
                                                    --admin-lastname=$ADMIN_LASTNAME \
                                                    --admin-email=$ADMIN_EMAIL \
                                                    --admin-user=$ADMIN_USER \
                                                    --admin-password=$ADMIN_PASSWORD \
                                                    --language=en_US \
                                                    --currency=USD \
                                                    --timezone=America/Los_Angeles \
                                                    --use-rewrites=1

# Change ownership of web root
sudo chown -R www-data:www-data /var/www/magento

# Reload Apache
sudo systemctl reload apache2.service

# bin/magento tasks
sudo php /var/www/magento/bin/magento indexer:reindex
sudo php /var/www/magento/bin/magento cache:flush
