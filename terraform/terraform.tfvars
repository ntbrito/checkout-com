/*
Use this file to overwrite default values defined in variables.tf or define new values
*/

## EC2
ec2_ssh_key = "checkout_key"
aws_ami = "ami-055c6079e3f65e9ac" # amazon-linux
ec2_type = "t3.micro"
instance_count = "1"

## VPC
covpc_cidr_block = "10.100.1.0/24"
coaz1_private    = "10.100.1.0/27"
coaz2_private    = "10.100.1.32/27"
coaz1_public     = "10.100.1.96/27"
coaz2_public     = "10.100.1.128/27"

## CheckOut AZs
co_az1 = "eu-west-2a"
co_az2 = "eu-west-2b"

# This allows me to alternate the azs where the instances are created
# I'll run into problems if I try to create more then 2 instances...
co_azs = ["eu-west-2a", "eu-west-2b"]

## Tags
project_name = "checkout"
