PATH_TO_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = whatever
PROJECT_NAME = inception

all: run

run:
	docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} up -d

force:
	docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} build --no-cache

run:

stop:
	docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} stop

clean:
	docker compose -p ${PROJECT_NAME} --file ${PATH_TO_COMPOSE} down -v

re: clean force all


