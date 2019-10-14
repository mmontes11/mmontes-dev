#!/usr/bin/env bash

proxy_confs="./config/nginx/proxy-confs"
mkdir -p "$proxy_confs"
cp -f nginx/*.conf "$proxy_confs"
cp -f nginx/nginx.conf "./config/nginx"
docker-compose up -d 
