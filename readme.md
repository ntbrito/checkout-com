#### Web page and http server
The initial plan was to use python and flask for the web page, mainly for the following reasons:
- simple to create a docker container
- possibility of using the code on a serverless environment like AWS Lambda

This idea was abandoned after reading the requirements more carefully and verifying that
this should simulate an enterprise-ready system and flask is not the best option in
this case.

Using another cgi server like flup would be time consuming as it would require to setup
the server from scratch since the offer on the internet is very outdated and again not
enterprise-level compliant software.

Ended up with apache and plain html

### -- For this project I am going to create the infrastructure using Terraform --
#### For that I need:

#### VPC with subneting
I need to create at least two subnets in two different AZs to support deploying servers
in different AZs (HA requirement)
#### EC2 Instance
This will run the web application from a Docker container
#### Security Groups
#### Elastic LB


#### Deploy this project
- terraform init
- terraform plan
- terraform apply


docker run -d --name jenkins --restart always -v ./jenkins_home:/var/jenkins_home -p 8080:8080 jenkins
git clone git://github.com/ntbrito/checkout-com.git