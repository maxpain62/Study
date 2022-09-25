resource "aws_security_group" "mysg" {
    vpc_id = aws_vpc.myvpc.id
    name = "mysg"
    description = "sg created with terraform"

    ingress {
      description = "allow ssh"
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
      Name = "mysg"
    }

}

