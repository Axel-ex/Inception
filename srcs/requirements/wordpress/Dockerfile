FROM debian:buster

#Instal php, php  fastcgi process manager
RUN apt update -y && apt upgrade -y
RUN apt install wget -y
RUN apt install -y vim
RUN apt install -y php7.3 php-fpm php-mysql mariadb-client

COPY conf/wp_config.sh ./wp_config.sh

RUN bash wp_config.sh
