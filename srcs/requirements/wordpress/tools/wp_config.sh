#!/bin/bash

# Ensure proper ownership and permissions
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

# Create necessary directories
mkdir -p /run/php/
touch /run/php/php7.3-fpm.pid

# Make PHP-FPM listen to port 9000
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf"

# Check if WordPress is already set up
if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: setting up..."

	# Create directory for nginx
	mkdir -p /var/www/html
	cd /var/www/html
	rm -rf *

	# Download wp-cli and WordPress
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp core download --allow-root

	# Wait for MariaDB to be ready
	while ! mysqladmin ping -hmariadb --silent; do
		echo "Waiting for MariaDB to be ready..."
		sleep 2
	done

	# Create wp-config.php and install WordPress
	wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PWD --dbhost=mariadb:3306
	wp core install --url=$WP_URL/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

	echo "Wordpress: setup complete!"
fi

# Execute the CMD from Dockerfile
exec "$@"
