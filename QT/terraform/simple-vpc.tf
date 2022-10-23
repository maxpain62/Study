provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "myvpc"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
      "Name" = "subnet1"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      "Name" = "subnet2"
    }
}
resource "aws_subnet" "subnet3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      "Name" = "subnet3"
    }
}
resource "aws_subnet" "subnet4" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.3.0/24"
    tags = {
      "Name" = "subnet4"
    }
}
resource "aws_subnet" "subnet5" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.4.0/24"
    tags = {
      "Name" = "subnet5"
    }
}
resource "aws_subnet" "subnet6" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.5.0/24"
    tags = {
      "Name" = "subnet6"
    }
}