terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_launch_template" "template" {
  name_prefix   = var.name_prefix
  image_id      = coalesce(var.ami_id, data.aws_ami.ubuntu.id)
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "asg" {
  name_prefix          = var.name_prefix
  desired_capacity     = var.min_size
  max_size             = var.max_size
  min_size             = var.min_size

  vpc_zone_identifier  = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = "0"

  tag {
    key   = "Name"
    value = "${var.name_prefix}-asg"
    propagate_at_launch = true
  }

  tag {
    key   = "environment"
    value = var.environment
    propagate_at_launch = true
  }
}
