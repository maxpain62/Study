variable "vpc_name" {
  type = string
}

variable "public_subnet_cidr" {
  type    = list
#  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "azs" {
  type = list
#  default = ["ap-south-1a", "ap-south-1b"]
}

