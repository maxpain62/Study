variable "targetregion" {
  type        = string
  description = "enter target region"
}

variable "vpccidr" {
  type        = string
  description = "enter desire cidr block"
}

variable "websubnetcidr" {
  type        = list(string)
  description = "enter desired subnet cidr block"
}
variable "webtargetaz" {
  type        = list(string)
  description = "enter desired availability zones"
}

variable "appsubnetcidr" {
  type        = list(string)
  description = "enter desired subnet cidr block"
}
variable "apptargetaz" {
  type        = list(string)
  description = "enter desired availability zones"
}

variable "dbsubnetcidr" {
    type = list(string)  
}
variable "dbtargetaz" {
    type = list(string)
}

variable "web-trigger" {
  type = string
  default = "1.0"
}