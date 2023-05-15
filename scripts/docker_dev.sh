#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

APP_DIR=$(realpath "${__dirname}/../app")
CACHE_DIR=$(realpath "${__dirname}/../cache")

NODE_INSPECT_PORT=$([ ! -z "${NODE_INSPECT_PORT}" ] && echo "${NODE_INSPECT_PORT}" || echo "9229")
REDIS_DATA_PATH=$([ ! -z "${REDIS_DATA_PATH}" ] && realpath "${REDIS_DATA_PATH}" || echo "${CACHE_DIR}/data")
REDIS_DATA_PATH=$(node --eval="process.stdout.write(path.resolve(process.argv[1]))" "${REDIS_DATA_PATH}")
REDIS_PORT=$([ ! -z "${REDIS_PORT}" ] && echo "${REDIS_PORT}" || echo "6379")
SERVER_PORT=$([ ! -z "${SERVER_PORT}" ] && echo "${SERVER_PORT}" || echo "1337")

docker build \
  --tag episen-sca/dev \
  --file ${APP_DIR}/Dockerfile \
  --target=dev \
  --build-arg REDIS_URL=redis://episen-sca_cache:6379 \
  ${APP_DIR}

docker build \
  --tag episen-sca/cache \
  --file ${CACHE_DIR}/Dockerfile \
  ${CACHE_DIR}

docker rm --force episen-sca_dev

docker rm --force episen-sca_cache

docker network rm episen-sca_network

docker network create episen-sca_network

docker run \
  --name episen-sca_cache \
  --detach \
  --network episen-sca_network \
  --publish ${REDIS_PORT}:6379 \
  --volume "${REDIS_DATA_PATH}:/data" \
  episen-sca/cache --maxmemory "16mb" --save "30 1"

docker run \
  --name episen-sca_dev \
  --detach \
  --mount type=bind,source=${APP_DIR}/lib/,target=/app/lib/ \
  --network episen-sca_network \
  --publish ${NODE_INSPECT_PORT}:9229 \
  --publish ${SERVER_PORT}:1337 \
  episen-sca/dev
