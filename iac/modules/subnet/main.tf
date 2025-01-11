terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.public_subnet_cidr, 2, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.name_prefix}-public-subnet-${element(var.availability_zones, count.index)}"
    environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.private_subnet_cidr, 2, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  tags = {
    Name        = "${var.name_prefix}-private-subnet-${element(var.availability_zones, count.index)}"
    environment = var.environment
  }
}
