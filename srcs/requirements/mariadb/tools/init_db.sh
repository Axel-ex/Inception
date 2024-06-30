#!/bin/bash

# Database configuration
db_name="mydb"
db_user="user"
db_pwd="1997"

service mysql start
# Create a SQL script file and add SQL commands to it
echo "CREATE DATABASE IF NOT EXISTS $db_name ;" >db1.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;" >>db1.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;" >>db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '42rules' ;" >>db1.sql
echo "FLUSH PRIVILEGES;" >>db1.sql

# Execute the SQL script using the MySQL client
mysql <db1.sql
