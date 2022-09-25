provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_instance" "web" {
  ami = "ami-0d87749f74c9b9ea7"
  instance_type = "t2.micro"
    
}
