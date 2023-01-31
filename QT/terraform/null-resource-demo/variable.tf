variable "target_region" {
    type = string
    description = "enter target region"
    default = "ap-south-1"
}

variable "private_key_file" {
    type = string
    default = "/root/Study/QT/terraform/command-execution-with-terraform/id_rsa"
}

variable "web-trigger" {
    type = string
    default = "1.0"  

}