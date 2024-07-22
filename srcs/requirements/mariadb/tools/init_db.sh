#!/bin/bash
#
mysql_install_db --user=$DB_USER --ldata=/var/lib/mysql
service mysql start

echo "DB_NAME " $DB_NAME
# Create a SQL script file and add SQL commands to it
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" >db.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD' ;" >>db.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >>db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '42rules' ;" >>db.sql
echo "FLUSH PRIVILEGES;" >>db.sql

# Execute the SQL script using the MySQL client
mysql <db.sql
