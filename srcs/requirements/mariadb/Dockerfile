FROM debian:buster

ARG DB_NAME
ARG DB_USER
ARG DB_PWD

ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PWD=${DB_PWD}

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y
RUN apt install vim -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init_db.sh ./init_db.sh
RUN bash init_db.sh

CMD ["/usr/bin/mysqld_safe"]
