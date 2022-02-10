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

echo "== Create docker container to run jenkins ==" >> /tmp/user_data.log

cd /home/ec2-user
git clone git://github.com/ntbrito/checkout-com.git
cd checkout-com/jenkins
docker build --rm -t jenkins .
docker run -d --name jenkins --restart always -p 8080:8080 jenkins


my-ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
sed -e "s/%%SHELLCOMMAND%%/ssh -i \/var\/jenkins_home\/.ssh\/id_rsa ec2-user@${my-ip} checkout-com\/bin\/build_webapp.sh/" \
-i /home/ec2-user/checkout-com/jenkins/jenkins_home/jobs/Deploy-WebApp/config.xml

echo "== Create docker container to run my_webapp ==" >> /tmp/user_data.log

cd /home/ec2-user
cd checkout-com/web_container
docker build --rm -t my_webapp .
docker run -d --name my_webapp --restart always -p 80:80 my_webapp

echo "== Bootstrap finished - $(date) ==" >> /tmp/user_data.log