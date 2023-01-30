resource "aws_instance" "test" {
  ami                         = "ami-06984ea821ac0a879"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-05349ad74b984768b"]
  associate_public_ip_address = true
  key_name                    = "laptop"

  connection {
    type     = "ssh"
    user     = "root"
    password = "ubuntu"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
        "touch /root/test"      
    ]
  }

  tags = {
    "Name" = "test"
  }
}
