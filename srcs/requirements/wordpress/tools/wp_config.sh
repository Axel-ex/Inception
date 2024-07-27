#!/bin/bash

#create directory for nginx
mkdir -p /var/www && mkdir -p /var/www/html
cd /var/www/html
rm -rf *

#download latest wordpress
wp core download --allow-root

# Wait for MariaDB to be ready
while ! mysqladmin ping -hmariadb --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 2
done

wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PWD --dbhost=mariadb:3306

#Install wordpress and sets up necessary info
wp core install --url=$WP_URL/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $DB_USER $WP_ADMIN_EMAIL --role=author --user_pass=$DB_PWD --allow-root

#make php fpm listen to port 9000
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf"

#php-fpm uses this directory to store unix domain sockets
mkdir /run/php

exec "$@"
