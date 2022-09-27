variable "ec2_name" {
  type = string
  
}

resource "aws_instance" "ec2" {
  ami = "ami-0d87749f74c9b9ea7"
  instance_type = "t2.micro"
  root_block_device {
    delete_on_termination = "true"
  }
  tags = {
    Name = var.ec2_name
  }
}

output "ec2_instance_id" {
  value = aws_instance.ec2.id
}
