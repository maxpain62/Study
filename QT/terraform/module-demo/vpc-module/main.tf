resource "aws_vpc" "module_demo" {
  cidr_block = var.module_cidr_block
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "module_subnet_demo_private" {
  count             = length(var.subnet_cidr_block)
  vpc_id            = aws_vpc.module_demo.id
  availability_zone = var.target_az[count.index]
  cidr_block        = var.subnet_cidr_block[count.index]
}

resource "aws_internet_gateway" "module_demo_itgw" {
  vpc_id = aws_vpc.module_demo.id
}

resource "aws_route_table" "module_demo_rttb_pub" {
  vpc_id = aws_vpc.module_demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.module_demo_itgw.id
  }
}

resource "aws_subnet" "module_subnet_demo_public" {
  count             = length(var.subnet_cidr_block_public)
  vpc_id            = aws_vpc.module_demo.id
  availability_zone = var.target_az_public[count.index]
  cidr_block        = var.subnet_cidr_block_public[count.index]
}

resource "aws_route_table_association" "module_demo_associaton" {
  count          = length(var.subnet_cidr_block_public)
  subnet_id      = element(aws_subnet.module_subnet_demo_public[*].id, count.index)
  route_table_id = aws_route_table.module_demo_rttb_pub.id
}