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

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_ids)

  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public_route_table.id
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
  subnet_id     = var.public_subnet_ids[0]
  depends_on    = [aws_eip.nat_eip, aws_internet_gateway.igw]

  tags = {
    Name        = "${var.name_prefix}-nat-gateway"
    environment = var.environment
  }
}
