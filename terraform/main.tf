locals {
  my_priv_subnet_id = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id]
  my_pub_subnet_id  = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
}
