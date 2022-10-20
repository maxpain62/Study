resource "aws_vpc" "tf_vpc" {
    cidr_block = var.cidr_range

    tags = {
      "Name" = "tf_vpc"
    }
  
}