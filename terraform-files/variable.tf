provider "aws" {
  region = "ap-south-1"
}

variable "myvpc" {
  type = string
  default = "myvpc"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enables" {
  default = true
}

variable "mylist" {
  type = list(string)
  default = ["value1","value2"]
}

variable "mymap" {
  type = map 
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

resource "aws_vpc" "terraformvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.myvpc
  }
}
