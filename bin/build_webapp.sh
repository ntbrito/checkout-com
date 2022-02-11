#!/usr/bin/env bash

cd /home/ec2-user/checkout-com/
git pull

if [[ $(docker ps -a | grep my_webapp) ]]
then
  # removing running container
  docker stop my_webapp
  docker rm my_webapp
  docker rmi my_webapp
fi

docker build --rm -t my_webapp .
docker run -d --name my_webapp -p 8080:8080 my_webapp