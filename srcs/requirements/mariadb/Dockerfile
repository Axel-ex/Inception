FROM debian:buster

RUN apt update && apt upgrade
RUN apt install mariadb-server -y
RUN apt install vim -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init_db.sh ./init_db.sh
RUN bash init_db.sh

CMD /usr/bin/mysqld_safe && \
	tail -f /dev/null
