FROM debian:buster

RUN apt upgrade && apt update
RUN apt install -y nginx
#install other utilities needed
RUN apt install -y vim 
#Set up the ssl certificats 
RUN apt install -y openssl
RUN mkdir -p /etc/nginx/ssl && mkdir -p /usr/share/nginx/logs/
RUN openssl req -nodes -x509 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=PT/L=Porto/CN=achabrer.42.fr/UID=achabrer"

#Copy our nginx config
COPY conf/nginx.conf /etc/nginx/nginx.conf

#give read write execute to root
RUN chmod 755 /var/www/html
#ownership to www-data user and groups
RUN chown -R www-data:www-data /var/www/html

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]
