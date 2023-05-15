#!/usr/bin/env sh

docker stop episen-sca_app
docker stop episen-sca_dev

docker stop episen-sca_cache

docker network rm episen-sca_network
