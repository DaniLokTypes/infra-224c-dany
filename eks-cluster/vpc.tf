resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    project     = var.project
    environment = var.environment
  }
}

resource "aws_subnet" "subnets" {
  for_each = {
    for idx, cidr in var.subnet_cidrs :
    idx => {
      cidr_block        = cidr
      availability_zone = var.availability_zones[idx]
    }
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    project     = var.project
    environment = var.environment
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    project     = var.project
    environment = var.environment
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }
  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    project     = var.project
    environment = var.environment
  }

}

resource "aws_route_table_association" "subnet_associations" {
  for_each       = aws_subnet.subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.route_table.id
}