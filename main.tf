terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
    backend "s3" {
    bucket = "remote-backend-suzumura"
    key    = "terraform/terraform.tfs"
    region = "us-east-1"
  }

}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "terraform" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = "false"

  tags = {
    "Name" = "terraform-${terraform.workspace}-vpc"
  }
}

resource "aws_subnet" "terraform-publicsubnet-1-a" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.public_subnet_1_a_cidr_block
  availability_zone = var.AZ_1_a
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "true"

  tags = {
    "Name" = "terraform-${terraform.workspace}-publicsubnet-1-a"
  }
}

resource "aws_subnet" "terraform-privatesubnet-1-a" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.private_subnet_1_a_cidr_block
  availability_zone = var.AZ_1_a
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "terraform-${terraform.workspace}-privatesubnet-1"
  }
}

resource "aws_subnet" "terraform-privatesubnet-1-c" {
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.private_subnet_1_c_cidr_block
  availability_zone = var.AZ_1_c
  assign_ipv6_address_on_creation = "false"
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "terraform-${terraform.workspace}-publicsubnet-1-c"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform.id

  tags = {
    "Name" = "terraform-${terraform.workspace}-igw"
  }
}

resource "aws_route_table" "terraform_rtb" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    "Name" = "terraform-${terraform.workspace}-rtb"
  }
}

resource "aws_route_table_association" "publicsubnet-1-rt" {
  subnet_id = aws_subnet.terraform-publicsubnet-1-a.id
  route_table_id = aws_route_table.terraform_rtb.id
}

