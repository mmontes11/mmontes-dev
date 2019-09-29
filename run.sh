#!/usr/bin/env bash

docker build -t mmontes-dev .
docker run --name mmontes-dev --network host --restart always -p 80:80/tcp -d mmontes-dev
