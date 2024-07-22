#!/bin/bash

mysql_install_db --user=mysql --ldata=/var/lib/mysql
service mysql start

# Wait for the MySQL server to be ready
until mysqladmin ping &>/dev/null; do
	echo "Waiting for MySQL server to be ready..."
	sleep 3
done

# Create a temporary MySQL configuration file for initialization
cat >/tmp/my.cnf <<EOF
[client]
user=root
password=''
EOF

# Create a SQL script file and add SQL commands to it
cat >/tmp/db.sql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PWD_ROOT}';
FLUSH PRIVILEGES;
EOF

# Execute the SQL script using the MySQL client
mysql --defaults-file=/tmp/my.cnf </tmp/db.sql

# Update the MySQL configuration file with the new root password
cat >/tmp/my.cnf <<EOF
[client]
user=root
password='$DB_PWD_ROOT'
EOF

# Shutdown the MySQL server
mysqladmin --defaults-file=/tmp/my.cnf shutdown

# Clean up
rm /tmp/my.cnf
rm /tmp/db.sql
