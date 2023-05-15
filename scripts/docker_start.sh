#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

APP_DIR=$(realpath "${__dirname}/../app")
CACHE_DIR=$(realpath "${__dirname}/../cache")

REDIS_PORT=$([ ! -z "${REDIS_PORT}" ] && echo ${REDIS_PORT} || echo "6379")
SERVER_PORT=$([ ! -z "${SERVER_PORT}" ] && echo ${SERVER_PORT} || echo "1337")

docker build \
  --tag episen-sca/app \
  --file ${APP_DIR}/Dockerfile \
  --build-arg REDIS_URL=redis://episen-sca_cache:6379 \
  ${APP_DIR}

docker build \
  --tag episen-sca/cache \
  --file ${CACHE_DIR}/Dockerfile \
  ${CACHE_DIR}

docker rm --force episen-sca_app

docker rm --force episen-sca_cache

docker network rm episen-sca_network

docker network create episen-sca_network

docker run \
  --name episen-sca_cache \
  --detach \
  --network episen-sca_network \
  --publish ${REDIS_PORT}:6379 \
  episen-sca/cache

docker run \
  --name episen-sca_app \
  --detach \
  --network episen-sca_network \
  --publish ${SERVER_PORT}:1337 \
  episen-sca/app
