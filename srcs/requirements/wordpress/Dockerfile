FROM debian:buster

ARG DB_NAME
ARG DB_USER
ARG DB_PWD
ARG WP_URL
ARG WP_TITLE
ARG WP_ADMIN_USR
ARG WP_ADMIN_PWD
ARG WP_ADMIN_EMAIL

ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PWD=${DB_PWD}
ENV WP_URL=${WP_URL}
ENV WP_TITLE=${WP_TITLE}
ENV WP_ADMIN_USR=${WP_ADMIN_USR}
ENV WP_ADMIN_PWD=${WP_ADMIN_PWD}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}

#Instal php, php  fastcgi process manager
RUN apt update -y && apt upgrade -y
RUN apt install -y vim
RUN apt install -y php7.3 php-fpm php-mysql mariadb-client
RUN apt install -y curl

COPY tools/wp_config.sh ./wp_config.sh

# Install wp-cli using curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN bash wp_config.sh

EXPOSE 9000

#Launch PHP FPM in foreground and ignore deamon
CMD ["/usr/sbin/php-fpm7.3", "-F"]
