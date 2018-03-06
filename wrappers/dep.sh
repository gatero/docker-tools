#!/usr/bin/env bash

# Setting up vars
. .docker-tools/setup-vars.sh

# Test if docker command exists
if ! [ -x "$(command -v docker)" ]; then
  echo -e "${RED}We love docker, give it a try...${NC}"
  echo -e "${YELLOW}To run this project docker must be installed${NC}"
  exit 1
fi

# Verify if the docker container exists
if docker ps -a | awk '{print $NF}' | grep -w "$APP_CONTAINER" > /dev/null 2>&1; then
  ACCEPTED_COMMANDS=('ensure' 'status')

  # This can be done better
  if echo "${ACCEPTED_COMMANDS[*]}" | grep -q -w "$1"; then
    echo -e "${GREEN}Going to run into ${YELLOW}${APP_CONTAINER}${GREEN}:${NC} dep $*"
    docker exec \
      "$APP_CONTAINER" \
      dep "$@"
    docker exec \
      "$APP_CONTAINER" \
      chown -R "$(id -u)":"$(id -g)" vendor Gopkg.*
  else
    echo -e "${RED}Unrecognized command: ${NC}$1"
  fi

else
  echo -e "${RED}We can find the container: ${NC}${APP_CONTAINER}"
fi
