provider "aws" {
    region = "ap-south-1"
}

module "vpc-module" {
    source = "./vpc-module"
    module_cidr_block = "10.0.0.0/16"
    vpc_name = "module_demo_vpc"
    target_az = ["ap-south-1a"]
    subnet_cidr_block = ["10.0.0.0/24"]
  
}