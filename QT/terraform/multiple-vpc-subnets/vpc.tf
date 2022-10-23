resource "aws_vpc" "tf_vpc" {
  count      = length(var.vpc_cidr_block)
  cidr_block = var.vpc_cidr_block[count.index]
  tags = {
    "Name" = "tf_vpc_${count.index}"
  }
}

resource "aws_internet_gateway" "tf_itgw" {
  vpc_id = aws_vpc.tf_vpc[0].id
}

resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_itgw.id
  }

  tags = {
    "Name" = "tf_rt_itgw"
  }
}

resource "aws_subnet" "primary_subnet" {
  vpc_id            = aws_vpc.tf_vpc[0].id
  count             = length(var.primary_subnet_cidr_block)
  cidr_block        = var.primary_subnet_cidr_block[count.index]
  availability_zone = var.target_availability_zone[count.index]
  tags = {
    "Name" = "primary_subnet_${count.index}"
  }
}

resource "aws_subnet" "primary_public_subnet" {
  vpc_id                                      = aws_vpc.tf_vpc[0].id
  count                                       = length(var.primary_public_subnet_cidr_block)
  cidr_block                                  = var.primary_public_subnet_cidr_block[count.index]
  availability_zone                           = var.primary_public_availability_zone[count.index]
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
  tags = {
    "Name" = "primary_public_subnet_${count.index}"
  }
}

resource "aws_route_table_association" "tf_rta" {
  subnet_id      = aws_subnet.primary_public_subnet[0].id
  route_table_id = aws_route_table.tf_rt.id
}

resource "aws_subnet" "secondary_subnet" {
  vpc_id            = aws_vpc.tf_vpc[1].id
  count             = length(var.secondary_subnet_cidr_block)
  cidr_block        = var.secondary_subnet_cidr_block[count.index]
  availability_zone = var.target_availability_zone[count.index]
  tags = {
    "Name" = "secondary_subnet_${count.index}"
  }
}
