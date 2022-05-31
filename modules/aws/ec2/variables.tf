variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

# variable "private_subnet_id" {
#   type = string
# }

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_security_group_ids" {
  type = string
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}