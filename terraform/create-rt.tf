/*
Route az1 private
*/
resource "aws_route_table" "az1_private" {
  vpc_id = aws_vpc.checkout_vpc.id
  # route to the internet - through the NGW
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.covpc_ngw_az2.id
  }
  
  tags = {
    Name        = "${var.project_name}-rt-az1-private"
    Environment = var.project_name
  }
}

resource "aws_route_table_association" "route_for_az1_private" {
  route_table_id = aws_route_table.az1_private.id
  subnet_id      = aws_subnet.private_subnet_az1.id
}

/*
Route az1 public
*/
resource "aws_route_table" "az1_public" {
  vpc_id = aws_vpc.checkout_vpc.id
  # route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.covpc_igw.id
  }

  tags = {
    Name        = "${var.project_name}-rt-az1-public"
    Environment = var.project_name
  }
}

resource "aws_route_table_association" "route_for_az1_public" {
  route_table_id = aws_route_table.az1_public.id
  subnet_id      = aws_subnet.public_subnet_az1.id
}

/*
Route az2 private
*/
resource "aws_route_table" "az2_private" {
  vpc_id = aws_vpc.checkout_vpc.id
  # route to the internet - through the NGW
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.covpc_ngw_az2.id
  }

  tags = {
    Name        = "${var.project_name}-rt-az2-private"
    Environment = var.project_name
  }
}

resource "aws_route_table_association" "route_for_az2_private" {
  route_table_id = aws_route_table.az2_private.id
  subnet_id      = aws_subnet.private_subnet_az2.id
}

/*
Route az2 public
*/
resource "aws_route_table" "az2_public" {
  vpc_id = aws_vpc.checkout_vpc.id
  # route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.covpc_igw.id
  }

  tags = {
    Name        = "${var.project_name}-rt-az2-public"
    Environment = var.project_name
  }
}

resource "aws_route_table_association" "route_for_az2_public" {
  route_table_id = aws_route_table.az2_public.id
  subnet_id      = aws_subnet.public_subnet_az2.id
}