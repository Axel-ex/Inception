PATH_TO_COMPOSE = ./srcs/docker-compose.yml
PATH_TO_ENV_FILE = whatever

build:
	docker compose --file ./srcs/docker-compose.yml --env-file ./srcs/.env  up --build
