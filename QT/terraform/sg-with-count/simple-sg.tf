terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "= 4.39"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_security_group" "simple_sg" {
    name = "simple_sg"
    description = "simple sg"
    tags = {
        Name = "simple_sg"
    }  
}

resource "aws_security_group_rule" "simple_sg_rule_ingress" {
    count = length(var.simple_sg_port)
    security_group_id = aws_security_group.simple_sg.id
    type = "ingress"
    from_port = var.simple_sg_port[count.index]
    to_port = var.simple_sg_port[count.index]
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "simple_sg_rule_egress" {
    security_group_id = aws_security_group.simple_sg.id
    type = "egress"
    from_port = -1
    to_port = -1
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
}