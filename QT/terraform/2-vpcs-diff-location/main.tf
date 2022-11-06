module "ap" {
  source = "./module"
  providers = {
    aws = aws.ap
  }
  vpccidr    = "10.0.0.0/16"
  subnetcidr = ["10.0.0.0/24", "10.0.1.0/24"]
  targetaz   = ["ap-south-1a", "ap-south-1b"]
}

module "us" {
  source = "./module"
  providers = {
    aws = aws.us
  }
  vpccidr    = "10.0.0.0/16"
  subnetcidr = ["10.0.0.0/24", "10.0.1.0/24"]
  targetaz   = ["us-west-1a", "us-west-1b"]
}
