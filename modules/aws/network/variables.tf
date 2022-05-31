variable "name" {
  type    = string
  default = ""
}

variable "vpc_cidr" {
  type = string
}

variable "subnets_public_cidr" {
  type = list(string)
}

variable "subnets_private_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}
