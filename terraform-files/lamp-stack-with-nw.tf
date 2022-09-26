provider "aws" {
  region = "ap-south-1"
  }

variable "sgrules_web" {
    type = list (number)
    default = [80,443]
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  # below line is to enable public ipv4 dns
  enable_dns_hostnames = "true"

    tags = {
      Name = "myvpc"
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
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"


  depends_on = [aws_internet_gateway.mygw]

  tags = {
    Name = "mysubnet_public"
  }
}

resource "aws_subnet" "mysubnet_private" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.16.0/20"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "mysubnet_private"
  }
}

resource "aws_route_table_association" "myroutetableassociation_private" {
    subnet_id = aws_subnet.mysubnet_private.id
    route_table_id = aws_vpc.myvpc.default_route_table_id
}

resource "aws_route_table_association" "myroutetableassociation_public" {
  subnet_id = aws_subnet.mysubnet_public.id
  route_table_id = aws_route_table.myroutetable_public.id
}

resource "aws_security_group" "mysg_web" {
  name = "mysg_web"
  description = "sg for web server"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.sgrules_web
    content {
    from_port = port.value
    to_port = port.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysg_web"
  }
}

resource "aws_security_group" "mysg_db" {
  name = "mysg_db"
  description = "sg for db server"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/20","10.0.16.0/20"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysg_db"
  }
}

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

  tags = {
    Name = "mysg_mgmt"
  }

}

resource "aws_eip" "myeip" {
  instance = aws_instance.myinstance_web.id
  vpc = "true"
  depends_on = [aws_internet_gateway.mygw]

  tags = {
    Name = "myeip"
  }
}

resource "aws_instance" "myinstance_web" {
  ami = "ami-0d87749f74c9b9ea7"
  subnet_id = aws_subnet.mysubnet_public.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg_web.id,aws_security_group.mysg_mgmt.id]
  user_data = file("server-script.sh")
  root_block_device {
    delete_on_termination = "true"
  }

  tags = {
    Name = "myinstance_web"
  }
}

resource "aws_instance" "myinstance_db" {
  ami = "ami-0d87749f74c9b9ea7"
  subnet_id = aws_subnet.mysubnet_private.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg_db.id,aws_security_group.mysg_mgmt.id]
  root_block_device {
    delete_on_termination = "true"
  }

  tags = {
    Name = "myinstance_db"
  }
}

output "PrivateIP-db"{
  value = aws_instance.myinstance_db.private_ip

}

