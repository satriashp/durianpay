terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}

resource "aws_security_group" "sg" {
  name   = "${var.name_prefix}-securirt-group"
  vpc_id = var.vpc_id

  # Allow all outbound traffic
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

   # Allow inbound SSH traffic (port 22)
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # Allow inbound http traffic
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # Allow communication between instances in the same security group
  ingress {
    self      = true  # This allows communication within the same security group
    from_port = 0
    to_port   = 0
    protocol  = "-1"  # Allows all protocols
  }

  tags = {
    Name        = "${var.name_prefix}-ssh-instance-security-group"
    environment = var.environment
  }
}
