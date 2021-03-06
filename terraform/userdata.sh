#!/usr/bin/env bash

# useradata script
today=$(date +%Y%m%d%H%M)

set -x

# this is not ideal but I need to wait for the networking to get ready otherwise some
# stuff down below will fail
sleep 120

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

myip=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

cd /home/ec2-user
git clone git://github.com/ntbrito/checkout-com.git
cd checkout-com/jenkins

sed -e "s/MYIP/${myip}/" -i jenkins_home/jobs/Deploy-WebApp/config.xml

docker build --rm -t jenkins .
docker run -d --name jenkins --restart always -p 8080:8080 jenkins

# I need to copy the public key to the ec2-user on the host
cat /home/ec2-user/checkout-com/jenkins/jenkins_home/.ssh/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys

echo "== Create docker container to run my_webapp ==" >> /tmp/user_data.log

cd /home/ec2-user/checkout-com/web_container
docker build --rm -t my_webapp .
docker run -d --name my_webapp --restart always -p 80:80 my_webapp

echo "== Bootstrap finished - $(date) ==" >> /tmp/user_data.log