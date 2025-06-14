#########################################
# Local Tags (Reusable Metadata)
#########################################

locals {
  common_tags = {
    Project     = var.vpc_name
    Environment = "dev"
    Owner       = "Theodoros"
    ManagedBy   = "Terraform"
  }
}

#########################################
# VPC
#########################################

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "vpc-${var.vpc_name}"
  })
}

#########################################
# Public Subnets
#########################################

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "public-subnet-${count.index + 1}"
  })
}

#########################################
# Private Subnets
#########################################

resource "aws_subnet" "private" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = element(var.availability_zones, count.index % length(var.availability_zones))
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "private-subnet-${count.index + 1}"
  })
}

#########################################
# Internet Gateway
#########################################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "internet-gateway-${var.vpc_name}"
  })
}

#########################################
# Public Route Table
#########################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "public-rt-${var.vpc_name}"
  })
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#########################################
# NAT Gateway
#########################################

resource "aws_eip" "nat" {
  tags = merge(local.common_tags, {
    Name = "nat-eip-${var.vpc_name}"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(local.common_tags, {
    Name = "nat-gateway-${var.vpc_name}"
  })

  depends_on = [aws_internet_gateway.this]
}

#########################################
# Private Route Table
#########################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "private-rt-${var.vpc_name}"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
