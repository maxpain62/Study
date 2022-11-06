create ntire architecture on aws
--------------------------------
* Step 1 - Declare provider
```
provider "aws" {
    region = var.targetregion  
}
```

* Step 2 - create vpc using code
```
resource "aws_vpc" "ntirevpc" {
  cidr_block           = var.vpccidr
  enable_dns_hostnames = "true"
}
```

* Step 3 - create bubnet with count variable and length function, refer below code
```
resource "aws_subnet" "websubnet" {
  count                                       = length(var.subnetcidr)

  vpc_id                                      = aws_vpc.ntirevpc
  cidr_block                                  = var.subnetcidr[count.index]
  availability_zone                           = var.targetaz[count.index]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"
  
  tags = {
    "Name" = "websubnet-${count.index}"
  }
}
```


* Step 4 - we also need to declare variable in variable.tf file, refer below example
```
variable "targetregion" {
    type = string
    description = "enter target region"  
}

variable "vpccidr" {
    type = string
    description = "enter desire cidr block"  
}

variable "subnetcidr" {
    type = list(string)
    description = "enter desired subnet cidr block"  
}

variable "targetaz" {
    type = list(string)
    description = "enter desired availability zones"
}
```

* Step 5 - assign value to variable in input.tfvars file
```
targetregion = "ap-south-1"
vpccidr      = "10.0.0.0/16"
subnetcidr   = ["10.0.0.0/24"]
targetaz     = ["ap-south-1a"]
```

* Step 6 - execute below commands - 

terraform init
terraform validate
terraform apply -var-file="input.tfvars"