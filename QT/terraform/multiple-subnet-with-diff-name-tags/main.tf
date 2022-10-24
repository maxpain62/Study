resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "tf_vpc"
  }
}

resource "aws_subnet" "tf_subnet" {
  count             = length(var.name_tags)
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.target_az[count.index]
  tags = {
    "Name" = var.name_tags[count.index]
  }
}