resource "aws_vpc" "tf_vpc" {
    count = 2
    cidr_block = var.vpc_cidr_block[count.index]
    tags = {
      "Name" = "tf_vpc_${count.index}"
    }
}

resource "aws_subnet" "primary_subnet" {
    vpc_id = aws_vpc.tf_vpc[0].id
    count = length(var.primary_subnet_cidr_block)
    cidr_block = var.primary_subnet_cidr_block[count.index]
    availability_zone = var.target_availability_zone[count.index]
    tags = {
      "Name" = "primary_subnet_${count.index}"
    }
}

resource "aws_subnet" "primary_public_subnet" {
    vpc_id = aws_vpc.tf_vpc[0].id
    count = length(var.primary_public_subnet_cidr_block)
    cidr_block = var.primary_public_subnet_cidr_block[count.index]
    availability_zone = var.primary_public_availability_zone[count.index]
    tags = {
      "Name" = "primary_public_subnet_${count.index}"
    }
  
}

resource "aws_subnet" "secondary_subnet" {
    vpc_id = aws_vpc.tf_vpc[1].id
    count = length(var.secondary_subnet_cidr_block)
    cidr_block = var.secondary_subnet_cidr_block[count.index]
    availability_zone = var.target_availability_zone[count.index]
    tags = {
      "Name" = "secondary_subnet_${count.index}"
    }
}