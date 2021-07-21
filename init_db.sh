#!/bin/bash
/usr/bin/mysqld_safe --skip-grant-tables &
sleep 5
# mysql -u root -e "CREATE DATABASE cms"
mysql -u root cms < /tmp/db.sql