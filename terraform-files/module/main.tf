provider "aws" {
  region = "ap-south-1"
  
}

module "ec2_module" {
  source = "./ec2-module"
  ec2_name = "module_demo"
}

output "ec2_module_output" {
  value = module.ec2_module.ec2_instance_id
}
