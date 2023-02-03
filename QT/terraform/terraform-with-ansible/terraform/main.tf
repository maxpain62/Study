resource "aws_instance" "tomcat" {
  ami                    = "ami-06984ea821ac0a879"
  subnet_id              = "subnet-0aec41c32cf6a3788"
  vpc_security_group_ids = ["sg-05349ad74b984768b"]
  key_name               = "terraform"
  instance_type          = "t2.micro"

  tags = {
    "Name" = "tomcat"
  }
}

resource "null_resource" "initial_setup" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "/home/ubuntu/Study/QT/terraform/terraform-with-ansible/terraform/terraform_key"
      host        = aws_instance.tomcat.public_ip
    }
    inline = [
      "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py"
    ]
  }

  depends_on = [
    aws_instance.tomcat
  ]
}