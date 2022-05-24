variable "region" {
  description = "Region of VPC"
  type        = string
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "CIDR Block of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_a_cidr_block" {
  description = "CIDR Block of public_subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_1_a_cidr_block" {
  description = "CIDR Block of private_subnet_1_a"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_c_cidr_block" {
  description = "CIDR Block of private_subnet_1_c"
  type        = string
  default     = "10.0.4.0/24"
}

variable "AZ_1_a" {
  description = "Avalability Zone 1-a"
  type        = string
  default     = "us-east-1a"
}

variable "AZ_1_c" {
  description = "Avalability Zone 1-c"
  type        = string
  default     = "us-east-1c"
}