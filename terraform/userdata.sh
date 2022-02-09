#!/usr/bin/env bash

# useradata script
today=$(date +%Y%m%d%H%M)

set -x

echo "== Starting User Data script - $(date) ==" > /tmp/user_data.log

# Make sure ssm is installed so we can open a shell on the instance
snap install amazon-ssm-agent
snap start amazon-ssm-agent

echo "== Updating System ==" >> /tmp/user_data.log
yum update -y

echo "== Install extra packages ==" >> /tmp/user_data.log

yum install -y wget \
               unzip \
               sysstat \
               git \
               jq \
               curl \
               python3 \
               python3-pip

amazon-linux-extras install docker
systemctl enable docker
systemctl restart docker

# Add ec2-user to the docker group
usermod -a -G docker ec2-user

# Install ansible
pip3 install ansible
pip3 install awscli

echo "== Create docker container to run my_webapp ==" >> /tmp/user_data.log

cd /home/ec2-user
git clone git://github.com/ntbrito/checkout-com.git
cd checkout-com/web_container
docker build --rm -t my_webapp .
docker run -d --name my_webapp --restart always -p 80:80 my_webapp

echo "== Bootstrap finished - $(date) ==" >> /tmp/user_data.log