resource "aws_subnet" "private_subnet_az1" {
  vpc_id            = aws_vpc.checkout_vpc.id
  cidr_block        = var.coaz1_private
  availability_zone = var.co_az1

  tags = {
    Name        = "${var.project_name}-private-AZ1"
    Environment = var.project_name
    Access      = "private"
  }
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id            = aws_vpc.checkout_vpc.id
  cidr_block        = var.coaz1_public
  availability_zone = var.co_az1

  tags = {
    Name        = "${var.project_name}-public-AZ1"
    Environment = var.project_name
    Access      = "public"
  }
}


resource "aws_subnet" "private_subnet_az2" {
  vpc_id            = aws_vpc.checkout_vpc.id
  cidr_block        = var.coaz2_private
  availability_zone = var.co_az2

  tags = {
    Name        = "${var.project_name}-private-AZ2"
    Environment = var.project_name
    Access      = "private"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id            = aws_vpc.checkout_vpc.id
  cidr_block        = var.coaz2_public
  availability_zone = var.co_az2

  tags = {
    Name        = "${var.project_name}-public-AZ2"
    Environment = var.project_name
    Access      = "public"
  }
}