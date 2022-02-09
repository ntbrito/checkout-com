resource "aws_security_group" "colb_sg" {
  name        = "${var.project_name} LB sec group"
  description = "Allow external traffic to the loadbalancer"
  vpc_id      = aws_vpc.checkout_vpc.id
  
  tags = {
    Name        = "${var.project_name}-LB-SG"
    Project     = var.project_name
  }
}

## We may need this if we ever configure the server for https
resource "aws_security_group_rule" "colb_443_in" {
  description       = "Allow https ingress"
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  security_group_id = aws_security_group.colb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "colb_80_in" {
  description       = "Allow 80 ingress"
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  security_group_id = aws_security_group.colb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "colb_8080_in" {
  description       = "Allow 8080 ingress"
  type              = "ingress"
  from_port         = "8080"
  to_port           = "8080"
  protocol          = "tcp"
  security_group_id = aws_security_group.colb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "colb_8081_in" {
  description       = "Allow 8081 ingress"
  type              = "ingress"
  from_port         = "8081"
  to_port           = "8081"
  protocol          = "tcp"
  security_group_id = aws_security_group.colb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "colb_all_out" {
  description       = "Allow egress everywhere"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  security_group_id = aws_security_group.colb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}