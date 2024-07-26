PATH_TO_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = whatever
PROJECT_NAME = inception
VOLUMES = /Users/Axel/data_inception/

all: run

run:
	sudo docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} up -d

force:
	sudo docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} build --no-cache

run:

stop:
	sudo docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} stop

clean:
	sudo docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} down
	rm -rf ${VOLUMES}

re: clean force all
