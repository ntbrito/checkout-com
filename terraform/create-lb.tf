# Create Elastic LoadBalancer
# the reason we are creating a LoadBalancer is mainly to keep the server ip private, avoiding to get it exposed to the internet
# also because we may want to do SSL termination on the loadbalancer and use AWS SSL certs

resource "aws_lb" "checkout_lb" {
  name               = var.project_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.colb_sg.id]
  subnets            = local.my_pub_subnet_id
  enable_deletion_protection = false

  tags = {
    Name        = "${var.project_name}-lb"
    Project     = var.project_name
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.checkout_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_lb_tg.arn
  }
}

resource "aws_lb_target_group" "webapp_lb_tg" {
  name     = "${var.project_name}-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.checkout_vpc.id
}

resource "aws_lb_target_group_attachment" "webapp_attach" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.webapp_lb_tg.arn
  target_id        = aws_instance.checkout_ec2[count.index].id
  port             = "80"
}

/*
resource "aws_lb_listener" "jenkins_listener" {
  load_balancer_arn = aws_lb.checkout_lb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_lb_tg.arn
  }
}

resource "aws_lb_target_group" "jenkins_lb_tg" {
  name     = "jenkins-tg"
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = aws_vpc.checkout_vpc.id
}

resource "aws_lb_target_group_attachment" "jenkins_attach" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.jenkins_lb_tg.arn
  target_id        = aws_instance.checkout_ec2[count.index].id
  port             = "8080"
}
*/