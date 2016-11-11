#!/bin/sh

MYSQL_ROOT_PASSWORD="password"
DB_USER="dbuser"
DB_PASSWORD="dbpassword"

set -e

apt-get -qqy update


# Insecure installation of MySQL
export DEBIAN_FRONTEND=noninteractive
apt-get install -qqy mysql-server

