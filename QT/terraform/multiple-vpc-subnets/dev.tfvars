target_region  = "ap-south-1"
vpc_cidr_block = ["192.168.0.0/16", "10.168.0.0/16"]

primary_public_subnet_cidr_block = ["192.168.0.0/24"]
primary_public_availability_zone = ["ap-south-1a"]

primary_subnet_cidr_block   = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
secondary_subnet_cidr_block = ["10.168.0.0/24", "10.168.1.0/24", "10.168.2.0/24", "10.168.3.0/24"]

target_availability_zone = ["ap-south-1a", "ap-south-1b", "ap-south-1c", "ap-south-1a"]
