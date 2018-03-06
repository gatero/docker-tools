#!/usr/bin/env bash

# Setting up vars
. .docker-tools/setup-vars.sh

# Stop and remove the instance image
echo -e "${GREEN}Stopping and removing the container: ${NC}${APP_CONTAINER}"
docker rm -f ${APP_CONTAINER}
