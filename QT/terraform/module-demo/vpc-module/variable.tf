variable "module_cidr_block" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "target_az" {
  type = list(string)
}

variable "subnet_cidr_block" {
  type = list(string)
}

variable "subnet_cidr_block_public" {
  type = list(string)
}

variable "target_az_public" {
  type = list(string)
}