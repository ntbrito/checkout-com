#### Web page and http server
The initial plan was to use python and flask for the web page for the following reasons:
- simpler to create a docker container
- don't need to install and configure an http server
- possibility of using the code on a serverless environment like AWS Lambda

This idea was abandoned after reading the requirements more carefully and verifying that
this should simulate an enterprise-ready system and flask is not the best option in
this case.

Using another cgi server like flup would be time consuming as it would require to setup
the server from scratch since the offer on the internet is very outdated and again not
enterprise-level compliant as required.

In the end the solution was to run apache from a docker container and use simple html for 
the web page. This way I can manage all the configuration and modifications I might need
to do on the webserver which makes it easier to automate.

#### -- For this project I am going to create the infrastructure using Terraform --
#### For that I need:

##### VPC with subneting
I need to create at least two subnets in two different AZs to support deploying servers
in different AZs (HA requirement)
Because I choose to keep the EC2 instance on a private network the VPC setup is a bit more
complicated as I need to create a NGW to have internet access
##### EC2 Instance
This will run the web application from a Docker container.
##### Security Groups
To provide security and allow traffic only to desired ports.
##### Elastic LB
This is required for 2 reasons:
- keep the server IP private
- balance the traffic and provide a ground for scaling and HA

#### Deploy this project
To deploy this project from scracth we need to clone the repository:
> git clone git://github.com/ntbrito/checkout-com.git

Once the repository is cloned we can change to the folder checkout-com/terraform and deploy
the entire infrastructure to support the project
> cd checkout-com/terraform

Then run the commands:
> terraform init \
terraform plan \
terraform apply (and confirm that you are okay to apply the changes)

This will deploy the infrastructure and the application.

##### Application deployment
In the case present here I am creating a docker container to run the http server, and I do
this at the EC2 creation time with an userdata script.
This simplifies the setup for a first installation of this service

Subsequent deployments can be done using the jenkins server provided with the solution, this is
accessible at http://loadbalancer.dns.name:8080, in my case it will be:
http://checkout-539481194.eu-west-2.elb.amazonaws.com:8080/
(user is "checkout" and password is CheckOut@2022)

This is a simple example and may not be up to enterprise standard, for that we would need a test
environment and some testing to be performed and only after all tests are passed we should build
for production.
That would require some knowledge in a testing framework that I do not have.

The userdata script creates the application container based on a container provided by the
Apache Foundation and the code is copied to the DocumentRoot folder on the web server.
No further configuration is required at this point.

#### A note on DNS
I did not configure DNS because that would involve registering a domain. To access the service we
must look at the DNS name of the loadbalancer, in my case pointing the browser to
http://checkout-539481194.eu-west-2.elb.amazonaws.com/ will open the website.
Another problem indirectly related with the lack of a DNS name is that I can not have an SSL
certificate and encrypt the traffic using HTTPS.

#### Documentation
You can find more details about networking on the pdf file Checkout.com-Scaling.pdf.
