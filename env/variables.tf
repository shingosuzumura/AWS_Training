variable "vpc_cidr" {
  type = map(string)

  default = {
    "staging"    = "10.10.0.0/16"
    "production" = "10.0.0.0/16"
  }
}

variable "vpc_public_subnets" {
  type = map(list(string))

  default = {
    "staging"    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
    "production" = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }
}

variable "vpc_private_subnets" {
  type = map(list(string))

  default = {
    "staging"    = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
    "production" = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  }
}

variable "availability_zone" {
  type = list(string)

  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

variable "instance_type" {
  type = map(string)

    default = {
    "staging"    = "t2.micro"
    "production" = "t2.micro"
  }
}

variable "key_name" {
  type = map(string)

  default = {
    "staging"    = "terrform_staging.pub"
    "production" = "terrform_production.pub"
  }
}

variable "public_key_path" {
  type = map(string)

  default = {
    "staging"    = ".ssh/terrform_staging.pub"
    "production" = ".ssh/terrform_production.pub"
  }
}