provider "aws" {
  region = "ap-south-1"
}

variable "input_vpc_id" {
  type = string
  description = "enter desired vpc id"
}

variable "sgrules" {
  type = list (number)
  default = [22,80,443]
}

resource "aws_security_group" "mysg" {
  name = "mysg"
  description = "test sg"
  vpc_id = var.input_vpc_id
  
    dynamic "ingress" {
      iterator = port
      for_each = var.sgrules
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
       Name = "mysg"
     }
    }
