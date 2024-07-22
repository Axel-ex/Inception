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
RUN apt install wget -y
RUN apt install -y vim
RUN apt install -y php7.3 php-fpm php-mysql mariadb-client

COPY conf/wp_config.sh ./wp_config.sh

# RUN bash wp_config.sh
CMD [ "tail", "-f",  "/dev/null"]
