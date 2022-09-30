resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "myroutetable_public" {
    vpc_id = aws_vpc.myvpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mygw.id
    }

    tags = {
      Name = "myroutetable_public"
    }
}

resource "aws_subnet" "mysubnet_public" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.myvpc.id
  cidr_block = element(var.public_subnet_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

resource "aws_route_table_association" "myroutetableassociation_public" {
  count = length(var.public_subnet_cidr)

  subnet_id = element(aws_subnet.mysubnet_public[*].id, count.index)
  route_table_id = aws_route_table.myroutetable_public.id
}

#resource "aws_route_table_association" "myroutetableassociation_public" {
#  subnet_id = aws_subnet.mysubnet_public.id
#  route_table_id = aws_route_table.myroutetable_public.id
#}

resource "aws_security_group" "mysg_mgmt" {
  name = "mysg_mgmt"
  description = "sg for management"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
