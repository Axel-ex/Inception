#!/bin/bash

# Ensure the data directory is initialized
echo "Initializing MariaDB data directory..."
mysql_install_db --user=mysql --ldata=/var/lib/mysql
echo "MariaDB data directory initialized."

# Start the MySQL server
echo "Starting MySQL server..."
mysqld_safe &
sleep 5

# Create a SQL script file and add SQL commands to it
echo "Creating initial SQL script..."
cat >/tmp/db.sql <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PWD_ROOT';
FLUSH PRIVILEGES;
EOF

echo "Initial SQL script created. Executing script..."
# Execute the SQL script using the MySQL client
mysql -uroot </tmp/db.sql
if [ $? -eq 0 ]; then
	echo "SQL script executed successfully."
else
	echo "Error executing SQL script."
	exit 1
fi
