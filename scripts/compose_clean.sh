#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

WORKDIR=$(echo "${__dirname}")

cd "${WORKDIR}"

docker compose \
  --file ../docker-compose.yaml \
  --project-name episen-sca \
  --profile default \
  --profile dev \
  --profile test \
  down

docker network rm episen-sca_network

docker rmi --force episen-sca/app
docker rmi --force episen-sca/dev
docker rmi --force episen-sca/cache
docker rmi --force episen-sca/test

docker image prune --force
docker network prune --force
docker volume prune --force
