resource "aws_vpc" "test" {
    cidr_block = var.cidr 

    tags = {
      "Name" = "tf_vpc"
    }
}

resource "aws_subnet" "tf_subnet" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.subnet_cidr

    tags = {
      "Name" = "tf_subnet"
    }
}
