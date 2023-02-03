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

resource "null_resource" "adding_ansible_files" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/Study/QT/terraform/terraform-with-ansible/terraform/terraform_key")
      host        = aws_instance.tomcat.public_ip
    }
    provisioner "file" {
        source = "/home/ubuntu/Study/QT/terraform/terraform-with-ansible/ansible"
        destination = "/home/ubuntu/"    
    }
  depends_on = [
    aws_instance.tomcat
  ]
}

resource "null_resource" "initial_setup" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/Study/QT/terraform/terraform-with-ansible/terraform/terraform_key")
      host        = aws_instance.tomcat.public_ip
    }
    inline = [
      "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py",
      "echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmNTDinVxsAL6fuZ3HW8o5jXXeOQQTfiEx7GVZFrBobFDY061MMIPHRvuJW/9ra+qARHfPLqteXsm9O1g9TM5B0QNmi41FZajy9Rk/FIvEfZ1gx5wFsVOzXb6BlyCgwqW5DYP7iTNYjYiOoxv7nHP0LLLe7OvU4FvQnBXZ7KkxY91oDbKyhggFFev/wKYbbofTsbAbxY4Obfnzzr9gqVPiDyKN7pwJfR4rbjAoBDsQD3EWGt2J1X4GyuL4q1pC6sw0oXYehOBMDltQJbCuU/qNhOUufj+LXpjLEpGn0tf/aG2CE6ffaiavedI3y3ilarlSWEXKRMTOYTqqhIkhlXlp >> /home/ubuntu/.ssh/authorized_keys",
      "python3 get-pip.py --user",
      "python3 -m pip install --user ansible",
      "echo 'PATH=$PATH:/home/ubuntu/.local/bin' >> /home/ubuntu/.bashrc",
      "ssh-keygen -t rsa -N '' -f localhost_key",
      "cat localhost_key.pub >> .ssh/authorized_keys",
      "cd /home/ubuntu/ansible/"
    ]
  }

  depends_on = [
    null_resource.adding_ansible_files
  ]
}
