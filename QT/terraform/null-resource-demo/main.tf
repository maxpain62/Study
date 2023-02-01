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
  provisioner "file" {
      connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("/root/Study/QT/terraform/command-execution-with-terraform/id_rsa")
        host = aws_instance.test.public_ip 
      }
    source      = "/home/ubuntu/tomcat"
    destination = "/home/ubuntu/tomcat"
  }
  depends_on = [ aws_instance.test ]
}

resource "null_resource" "webprovisoner2" {
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
        "sudo apt update -y && sudo apt install software-properties-common -y && sudo add-apt-repository --yes --update ppa:ansible/ansible && sudo apt install ansible -y",
        "cd /home/ubuntu/tomcat/ && sudo ansible-playbook -i hosts tomcat-installation-sample.yml"
      ]
    }
    depends_on = [ null_resource.webprovisoner ]
}