resource "aws_vpc" "ntirevpc" {
  cidr_block           = var.vpccidr
  enable_dns_hostnames = "true"

  tags = {
    "Name" = "ntirevpc"
  }
}


resource "aws_subnet" "websubnet" {
  count = length(var.websubnetcidr)

  vpc_id                                      = aws_vpc.ntirevpc.id
  cidr_block                                  = var.websubnetcidr[count.index]
  availability_zone                           = var.webtargetaz[count.index]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    "Name" = "websubnet-${count.index}"
  }
}


resource "aws_subnet" "appsubnet" {
  count = length(var.appsubnetcidr)

  vpc_id                                      = aws_vpc.ntirevpc.id
  cidr_block                                  = var.appsubnetcidr[count.index]
  availability_zone                           = var.apptargetaz[count.index]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    "Name" = "appsubnet-${count.index}"
  }
}


resource "aws_subnet" "dbsubnet" {
  count = length(var.dbsubnetcidr)

  vpc_id                                      = aws_vpc.ntirevpc.id
  cidr_block                                  = var.dbsubnetcidr[count.index]
  availability_zone                           = var.dbtargetaz[count.index]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    "Name" = "dbsubnet${count.index}"
  }
}

resource "aws_internet_gateway" "itgw" {
  vpc_id = aws_vpc.ntirevpc.id
}

resource "aws_route_table" "pubrttb" {
  vpc_id = aws_vpc.ntirevpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.itgw.id
  }

  tags = {
    "Name" = "webrttb"
  }
}
resource "aws_route_table_association" "pubrttbassociation" {
  count = length(var.websubnetcidr)

  subnet_id      = aws_subnet.websubnet[count.index].id
  route_table_id = aws_route_table.pubrttb.id
}

resource "aws_route_table" "apprttb" {
  vpc_id = aws_vpc.ntirevpc.id

  tags = {
    "Name" = "apprttb"
  }
}
resource "aws_route_table_association" "apprttbassociation" {
  count = length(var.appsubnetcidr)

  subnet_id      = aws_subnet.appsubnet[count.index].id
  route_table_id = aws_route_table.apprttb.id
}


resource "aws_route_table" "dbrttb" {
  vpc_id = aws_vpc.ntirevpc.id

  tags = {
    "Name" = "dbrttb"
  }

}
resource "aws_route_table_association" "dbrttbassociation" {
  count = length(var.dbsubnetcidr)

  subnet_id      = aws_subnet.dbsubnet[count.index].id
  route_table_id = aws_route_table.dbrttb.id
}

resource "aws_security_group" "websg" {

  description = "security group for web access"
  name        = "websg"
  vpc_id      = aws_vpc.ntirevpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "websg"
  }
}

resource "aws_instance" "webinstance" {
  ami                         = "ami-0d87749f74c9b9ea7"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.websubnet[0].id
  vpc_security_group_ids = [aws_security_group.websg.id]
  associate_public_ip_address = true
  key_name                    = "laptop"
}


resource "null_resource" "webprovisoner" {
  triggers = {
    running_number = var.web-trigger
  }
  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "root"
      password    = "redhat"
#      private_key = file("D:/study/aws/keys/laptop")
      host        = aws_instance.webinstance.public_ip
    }

    inline = [
      "yum install tree -y"
    ]

  }
  depends_on = [aws_instance.webinstance]
}
