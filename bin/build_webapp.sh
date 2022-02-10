#!/usr/bin/env bash

cd /home/ec2-user/checkout-com/web_container

if [[ $(docker ps -a | grep my_webapp) ]]
then
  docker stop my_webapp
  docker rm my_webapp
fi

docker build --rm -t my_webapp .
docker run -d --name my_webapp -p 8080:8080 my_webapp