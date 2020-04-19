#!/usr/bin/env bash

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

project="mmontes-dev"
version="1.0.0"
platform="linux/amd64,linux/arm64"
image="$DOCKER_USERNAME/$project:$version"

echo "👷   Creating builder $project ..."
docker buildx create --name "$project"
docker buildx use "$project"

echo "🏗    Building $image ..."
docker buildx build --platform "$platform" -t "$image" --push .
docker buildx imagetools inspect "$image"
