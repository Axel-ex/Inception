FROM debian:buster

RUN apt upgrade && apt update
RUN apt install -y nginx
#install other utilities needed
RUN apt install -y vim 
#Set up the ssl certificats 
RUN apt install -y openssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -nodes -x509 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=PT/L=Porto/CN=achabrer.42.fr/UID=achabrer"

COPY conf/nginx.conf 
