PATH_TO_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = whatever
PROJECT_NAME = inception
DATA_DIR = /Users/Axel/data/

all: conf up

conf:
	@mkdir -p ${DATA_DIR}mariadb_volume/ ${DATA_DIR}wordpress_volume/
	@sudo sed -i '' '/^127.0.0.1/ s/localhost/localhost achabrer.42.fr/' /etc/hosts

up:
	docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} up --build -d

down:
	docker compose -p ${PROJECT_NAME} down --volumes

start:
	docker compose -p ${PROJECT_NAME} start

stop:
	docker compose -p ${PROJECT_NAME} stop

clean_images:
	@echo "Removing images...\n"
	docker rmi -f $(docker images -q) || True

clean: down clean_images

fclean: clean
	@echo "Removing volumes...\n"
	rm -rf ${DATA_DIR}

re: fclean all
