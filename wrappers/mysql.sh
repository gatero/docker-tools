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
if docker ps -a | awk '{print $NF}' | grep -w "$DB_CONTAINER" > /dev/null 2>&1; then
  ACCEPTED_COMMANDS=('create-dump' 'mysql-run')

  # This can be done better
  if echo "${ACCEPTED_COMMANDS[*]}" | grep -q -w "$1"; then
    echo -e "${GREEN}Going to run into ${YELLOW}${DB_CONTAINER}${GREEN}:${NC} $*"
    docker exec \
      "$DB_CONTAINER" \
      mysql-wrapper.sh "$@"
  else
    echo -e "${RED}Unrecognized command: ${NC}$1"
  fi

else
  echo -e "${RED}We can find the container: ${NC}${DB_CONTAINER}"
fi
