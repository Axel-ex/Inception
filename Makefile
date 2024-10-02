PATH_TO_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = whatever
PROJECT_NAME = inception
DATA_DIR = /home/achabrer/data/

all: conf up

conf:
	@sudo mkdir -p ${DATA_DIR}mariadb_volume/ ${DATA_DIR}wordpress_volume/
	@sudo sed -i '/^127.0.0.1/ s/localhost/localhost achabrer.42.fr/' /etc/hosts || true

up:
	sudo docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} up --build -d

down:
	sudo docker compose -p ${PROJECT_NAME} down --volumes

start:
	sudo docker compose -p ${PROJECT_NAME} start

stop:
	sudo docker compose -p ${PROJECT_NAME} stop

clean_images:
	@echo "Removing images...\n"
	sudo docker rmi -f $$(sudo docker image ls -q) || true
	sudo docker builder prune -f

clean: down clean_images

fclean: clean
	@echo "Removing volumes...\n"
	sudo rm -rf ${DATA_DIR}

re: fclean all
