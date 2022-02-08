resource "aws_security_group" "app_sec_group" {
  name        = "${var.project_name} sec group"
  description = "Allow traffic to ${var.project_name}"
  vpc_id      = aws_vpc.checkout_vpc.id

  tags = {
    Name        = "${var.project_name}-app-Sec-Group"
    Project     = var.project_name
  }
}

resource "aws_security_group_rule" "http_in" {
  description       = "HTTP access"
  type              = "ingress"
  from_port         = "8080"
  to_port           = "8080"
  protocol          = "tcp"
  security_group_id = aws_security_group.app_sec_group.id
  cidr_blocks       = [var.covpc_cidr_block]
}

resource "aws_security_group_rule" "http8081_in" {
  description       = "HTTP 8081 access"
  type              = "ingress"
  from_port         = "8081"
  to_port           = "8081"
  protocol          = "tcp"
  security_group_id = aws_security_group.app_sec_group.id
  cidr_blocks       = [var.covpc_cidr_block]
}

resource "aws_security_group_rule" "all_out" {
  description       = "Allow egress everywhere"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  security_group_id = aws_security_group.app_sec_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}