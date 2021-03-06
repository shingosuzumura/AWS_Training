resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnets_public_cidr)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.subnets_public_cidr, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.subnets_public_cidr)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.subnets_private_cidr)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "private" {
  count = length(var.subnets_private_cidr)

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.subnets_private_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    "Name" : var.name,
    "Terraform" : "true"
  }
}

