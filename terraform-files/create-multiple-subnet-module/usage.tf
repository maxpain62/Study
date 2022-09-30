provider "aws" {
  region = "ap-south-1"
}

module "vpc_module" {
  source = "./vpc"
  vpc_name = "myvpc"
  public_subnet_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
}

