#!/bin/sh

MYSQL_ROOT_PASSWORD="password"
DB_USER="dbuser"
DB_PASSWORD="dbpassword"

set -e

apt -qqy update

debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

apt install -qqy mysql-server

