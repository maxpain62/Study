resource "aws_instance" "test" {
  ami                         = "ami-06984ea821ac0a879"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-05349ad74b984768b"]
  associate_public_ip_address = true
  key_name                    = "terraform"

  connection {
    type = "ssh"
    user = "ubuntu"
    host     = self.public_ip
    private_key = "${file(var.private_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "touch /tmp/foo.txt",
    ]
  }

  tags = {
    "Name" = "test"
  }
}
