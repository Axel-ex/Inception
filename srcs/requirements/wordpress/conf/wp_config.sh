#!/bin/bash

#get cli word press to automatically link with our datbase.
wget -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#create directory for nginx
mkdir -p /var/www && mkdir -p /var/www/html
#download latest wordpress
wp core download --path=/var/www/html --allow-root

wp config create --allow-root \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PWD \
	--dbhost=mariadb:3306 --path='/var/www/html'

#Install wordpress and sets up necessary info
wp core install --url=$WP_URL/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

#make php fpm listen to port 9000
sed -i 's/^listen =.*/listen = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.3 -F
