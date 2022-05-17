terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "terraform" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = "false"

  tags = {
    "Name" = "terraform_vpc"
  }
}

resource "aws_subnet" "terraform-publicsubnet-1-a" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "true"

  tags = {
    "Name" = "terraform-publicsubnet-1-a"
  }
}

resource "aws_subnet" "terraform-privatesubnet-1-a" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "terraform-privatesubnet-1"
  }
}

resource "aws_subnet" "terraform-privatesubnet-1-c" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1c"
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "terraform-publicsubnet-1-c"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform.id

  tags = {
    "Name" = "terraform_igw"
  }
}

resource "aws_route_table" "terraform_rtb" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    "Name" = "terraform_rtb"
  }
}

resource "aws_route_table_association" "publicsubnet-1-rt" {
  subnet_id = aws_subnet.terraform-publicsubnet-1-a.id
  route_table_id = aws_route_table.terraform_rtb.id
}

