provider "aws" {
  region = "ap-south-1"

}

variable "vpc_name" {
  type = string
  default = "test_vpc"
}

resource "aws_vpc" "test_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = var.vpc_name
    }
}

output "vpcid"{
  value = aws_vpc.test_vpc.id
}
