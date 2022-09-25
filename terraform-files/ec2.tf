resource "aws_instance" "myinstance" {
    subnet_id = aws_subnet.mysubnet.id
    ami = "ami-0d87749f74c9b9ea7"
    instance_type = "t2.micro"
    private_ip = "10.0.0.5"
    root_block_device {
      delete_on_termination = "true"
    }

    tags = {
      Name = "myinstance"
    }
}

