#!/usr/bin/env bash
APP_NAME=begin_vegan

echo "> Check the currently running container"
CONTAINER_ID=$(docker ps -aqf "name=$APP_NAME")
echo "$CONTAINER_ID"

if [ -z "$CONTAINER_ID" ];
then
  echo "> No such container is running."
else
  echo "> Stop and remove container: $CONTAINER_ID"
  docker stop "$CONTAINER_ID"
  docker rm "$CONTAINER_ID"
fi

echo "> Build Docker image"
docker build -t "$APP_NAME" .

echo "> Run the Docker container"
docker run -d -p 3000:8080 --name "$APP_NAME" "$APP_NAME"

echo "> Remove previous Docker image"
docker rmi "$APP_NAME:previous"