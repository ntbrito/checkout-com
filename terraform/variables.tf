## EC2
variable "ec2_ssh_key" { description = "SSH Key for the EC2 hosts" }
variable "ec2_type" { description = "EC2 type" }
variable "aws_ami" { description = "AWS EC2 AMI" }
variable "instance_count" { description = "# of instances" }

## CheckOut VPC
variable "covpc_cidr_block" { description = "CO VPC CIDR Block" }
variable "coaz1_private" { description = "CO AZ1 Private CIDR Block" }
variable "coaz2_private" { description = "CO AZ2 Private CIDR Block" }
variable "coaz1_public" { description = "CO AZ1 Public CIDR Block" }
variable "coaz2_public" { description = "CO AZ2 Public CIDR Block" }

## CheckOut AZs
variable "co_az1" {description = "CO AZ1"}
variable "co_az2" {description = "CO AZ2"}

variable "co_azs" {
  description = "CheckOut AZs"
  type        = list
}

## Tags
variable "project_name" { description = "Name of the project" }