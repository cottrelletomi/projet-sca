#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

WORKDIR=$(echo "${__dirname}")

cd "${WORKDIR}"

docker compose \
  --file ../docker-compose.yaml \
  --project-name episen-sca \
  --profile default \
  up --build --detach
