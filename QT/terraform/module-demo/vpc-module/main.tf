resource "aws_vpc" "module_demo" {
    cidr_block = var.module_cidr_block  
    tags = {
      "Name" = var.vpc_name
    }

}

resource "aws_subnet" "module_subnet_demo" {
    count = length(var.subnet_cidr_block)
    vpc_id = aws_vpc.module_demo.id
    availability_zone = var.target_az[count.index]
    cidr_block = var.subnet_cidr_block[count.index]
}