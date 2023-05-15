#!/usr/bin/env sh

docker rm --force episen-sca_app
docker rm --force episen-sca_dev
docker rm --force episen-sca_cache
docker rm --force episen-sca_test

docker network rm episen-sca_network

docker rmi --force episen-sca/app
docker rmi --force episen-sca/dev
docker rmi --force episen-sca/cache
docker rmi --force episen-sca/test

docker image prune --force
docker network prune --force
docker volume prune --force
