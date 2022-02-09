# This template creates a NAT GW for the VPC

## NAT GW for subnet AZ1
# Elastic IP
resource "aws_eip" "eip_ngw_az1" {

  tags = {
    Name        = "${var.project_name}-NGW-EIP"
    Environment = var.project_name
  }

}

# NAT GW
resource "aws_nat_gateway" "covpc_ngw_az1" {
  depends_on    = [aws_internet_gateway.covpc_igw]
  allocation_id = aws_eip.eip_ngw_az1.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name        = "${var.project_name}-NGW-AZ1"
    Environment = var.project_name
  }

}

## NAT GW for subnet AZ2
# Elastic IP
resource "aws_eip" "eip_ngw_az2" {

  tags = {
    Name        = "${var.project_name}-NGW-EIP"
    Environment = var.project_name
  }

}

# NAT GW
resource "aws_nat_gateway" "covpc_ngw_az2" {
  depends_on    = [aws_internet_gateway.covpc_igw]
  allocation_id = aws_eip.eip_ngw_az2.id
  subnet_id     = aws_subnet.public_subnet_az2.id

  tags = {
    Name        = "${var.project_name}-NGW-AZ2"
    Environment = var.project_name
  }
}