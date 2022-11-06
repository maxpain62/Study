variable "vpccidr" {
  type = string
}

variable "targetaz" {
    type = list(string)  
}

variable "subnetcidr" {
    type = list(string)  
}