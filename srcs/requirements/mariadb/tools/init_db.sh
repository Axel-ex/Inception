#!/bin/bash

# Ensure the data directory is initialized
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Create a SQL script file and add SQL commands to it
cat >/tmp/db.sql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PWD_ROOT}';
FLUSH PRIVILEGES;
EOF

# Execute the SQL script using the MySQL client
mysql -uroot </tmp/db.sql

# Stop the MySQL server
mysqladmin -uroot -p${DB_PWD_ROOT} shutdown

# Clean up
rm /tmp/db.sql
