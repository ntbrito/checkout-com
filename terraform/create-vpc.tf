/*
Deploy VPC
> terraform plan
> terraform apply
*/

# Create Internet VPC
resource "aws_vpc" "checkout_vpc" {
  cidr_block           = var.covpc_cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name        = "${var.project_name}-VPC"
    Environment = var.project_name
  }
}

# Create Internet GW
resource "aws_internet_gateway" "covpc_igw" {
  vpc_id = aws_vpc.checkout_vpc.id

  tags = {
    Name        = "${var.project_name}-IGW"
    Environment = var.project_name
  }
}