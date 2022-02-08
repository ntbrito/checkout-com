# Create EC2 instances to host the service
# Note: we are creating the instance on a public network to be able to easily open a ssh session to it
# in a real scenario the instance will be created with a private IP only and accessible to the internet
# through the ELB

resource "aws_instance" "checkout_ec2" {
  count                  = var.instance_count
  ami                    = var.aws_ami
  instance_type          = var.ec2_type
  availability_zone      = var.co_azs[count.index]
  subnet_id              = local.my_priv_subnet_id[count.index]
  key_name               = var.ec2_ssh_key
  ebs_optimized          = "true"
  vpc_security_group_ids = [aws_security_group.app_sec_group.id]

  root_block_device {
    volume_size = "20"
    delete_on_termination = "true"
  }

  tags = {
    Name    = "${var.project_name}-${count.index}"
    Project = var.project_name
  }

  user_data = base64encode(file("${path.module}/userdata.sh"))

  lifecycle {
    create_before_destroy = true
    ignore_changes = [user_data]
  }
}