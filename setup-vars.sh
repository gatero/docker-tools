#!/usr/bin/env bash

export GREEN='\033[0;32m'
export RED='\033[0;31m'
export YELLOW='\033[1;33m'
export NC='\033[0m'

echo -e "${GREEN}Setting up the ENV vars...${NC}"

. .env
