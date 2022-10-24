variable "target_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}

variable "name_tags" {
  type = list(string)
}

variable "target_az" {
  type = list(string)
}