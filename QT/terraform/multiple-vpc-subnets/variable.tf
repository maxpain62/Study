variable "target_region" {
  type = string
}

variable "vpc_cidr_block" {
  type = list(string)
}

variable "primary_subnet_cidr_block" {
  type = list(string)
}

variable "secondary_subnet_cidr_block" {
  type = list(string)

}

variable "target_availability_zone" {
  type = list(string)
}

variable "primary_public_subnet_cidr_block" {
  type = list(string)
}

variable "primary_public_availability_zone" {
  type = list(string)
}