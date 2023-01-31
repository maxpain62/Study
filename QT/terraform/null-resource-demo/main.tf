resource "aws_instance" "test" {
  ami                         = "ami-06984ea821ac0a879"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-05349ad74b984768b"]
  associate_public_ip_address = true
  key_name                    = "terraform"

  tags = {
    "Name" = "test"
  }
}

resource "null_resource" "webprovisoner" {
  triggers = {
    running_number = var.web-trigger
  }

  provisioner "remote-exec" {
      connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("/root/Study/QT/terraform/command-execution-with-terraform/id_rsa")
        host = aws_instance.test.public_ip 
      }
      inline = [
        "sudo apt update",
        "sudo apt install nginx -y",
        "sudo apt install tree -y"
      ]
    }
    depends_on = [ aws_instance.webec2 ]
}