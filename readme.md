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

#### -- For this project I am going to create the infrastructure using Terraform --
#### For that I need:

##### VPC with subneting
I need to create at least two subnets in two different AZs to support deploying servers
in different AZs (HA requirement)
Because I choose to keep the EC2 instance on a private network the VPC setup is a bit more
complicated as I need to create a NGW to have internet access
##### EC2 Instance
This will run the web application from a Docker container
##### Security Groups
To provide security and allow traffic only to desired ports
##### Elastic LB
To balance the traffic and provide a ground for scaling and HA

#### Deploy this project
To deploy this project from scracth we need to clone the repository:
> git clone git://github.com/ntbrito/checkout-com.git

Once the repository is cloned we can change to the folder checkout-com/terraform and deploy
the entire infrastructure to support the project
> cd checkout-com/terraform

Then run the commands:
> terraform init \
terraform plan \
terraform apply

This will deploy the infrastructure.

##### Application deployment
In the case present here I am creating a docker container to run the http server, and I do
this at the EC2 creation time with an userdata script. This simplifies the setup as I don't
need to create another service for CI/CD like Jenkins for instance, however it's a bit prone
to errors as the execution of the userdata script is out of my control, and it can run into
issues if networking is not available yet, for instance.
This may also be an over complicated way to deploy in case of updates.

The userdata script creates the container based on a container provided by apache and the code
is copied to the DocumentRoot folder on the web server. No further configuration is required at
this point.

#### A note on DNS
I did not configure DNS because that would involve registering a domain. To access the service
must look at the DNS name of the loadbalancer, in my case pointing the browser to
http://checkout-1510521244.eu-west-2.elb.amazonaws.com/ will open the web site.
Another problem undirectly related with the lack of a DNS name is that I can not have an SSL
cerificate and secure the traffic using HTTPS.