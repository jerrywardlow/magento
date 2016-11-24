#!/bin/sh

yum install -y httpd

systemctl start httpd.service

systemctl enable httpd.service


yum install -y mariadb-server mariadb

systemctl start mariadb.service

systemctl enable mariadb.service
