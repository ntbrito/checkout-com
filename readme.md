#### Web page and http server
The initial plan was to use python and flask for the web page, mainly for the following reasons:
- simpler to create a docker container
- possibility of using the code on a serverless environment like AWS Lambda

This idea was abandoned after reading the requirements more carefully and verifying that
this should simulate an enterprise-ready system and flask is not the best option in
this case.

Using another cgi server like flup would be time consuming as it would require to setup
the server from scratch since the offer on the internet is very outdated and again not
enterprise-level compliant software.

In the end the solution was to run apache from a docker container and html for the web page
and copy the content into teh container. This way I can manage all the configuration and
modifications i might do on the webserver.

### -- For this project I am going to create the infrastructure using Terraform --
#### For that I need:

#### VPC with subneting
I need to create at least two subnets in two different AZs to support deploying servers
in different AZs (HA requirement)
#### EC2 Instance
This will run the web application from a Docker container
#### Security Groups
To provide security and allow traffic only to desired ports
#### Elastic LB
To balance the traffic and provide a ground for scaling and HA

#### Deploy this project
To deploy this project from scracth we need to clone the repository:
> git clone git://github.com/ntbrito/checkout-com.git

Once the repository is cloned we can change to the folder checkout-com and terraform and deploy
the infrastructure to support the project
> cd checkout-com/terraform

Then run the commands:

> terraform init \
terraform plan \
terraform apply

This will deploy the infrastructure.
