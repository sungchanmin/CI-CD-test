#!/usr/bin/env bash
APP_NAME=begin_vegan

touch logCheck

echo "> Check the currently running container" >> logCheck
CONTAINER_ID=$(docker ps -aqf "name=$APP_NAME")
echo "$CONTAINER_ID" >> logCheck

if [ -z "$CONTAINER_ID" ];
then
  echo "> No such container is running." >> logCheck
else
  echo "> Stop and remove container: $CONTAINER_ID" >> logCheck
  docker stop "$CONTAINER_ID"
  docker rm "$CONTAINER_ID"
fi

echo "> Remove previous Docker image" >> logCheck
docker rmi "$APP_NAME"

echo "> Build Docker image" >> logCheck
docker build -t "$APP_NAME" .

echo "> Run the Docker container" >> logCheck
docker run -d -p 3000:8080 --name "$APP_NAME" "$APP_NAME"

