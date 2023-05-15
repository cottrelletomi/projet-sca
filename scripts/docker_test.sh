#!/usr/bin/env sh

__filename=$(realpath "${0}")
__dirname=$(dirname "${__filename}")

APP_DIR=$(realpath "${__dirname}/../app")

docker build \
  --tag episen-sca/test \
  --file ${APP_DIR}/Dockerfile \
  --target=test ${APP_DIR}

docker stop episen-sca_test

docker rm --force episen-sca_test

docker run \
  --name episen-sca_test \
  episen-sca/test
