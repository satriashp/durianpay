terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.name_prefix}-igw"
    environment = var.environment
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "${var.name_prefix}-eip"
    environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
  depends_on    = [aws_eip.nat_eip, aws_internet_gateway.igw]

  tags = {
    Name        = "${var.name_prefix}-nat-gateway"
    environment = var.environment
  }
}
