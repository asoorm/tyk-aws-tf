variable "region" {
  type = "string"
  description = "Main region to deploy Tyk. Eg: `eu-west-2`"
}

variable "cidr_block" {
  type = "string"
  description = "Main CIDR block. Eg: 10.0.0.0/16"
}

variable "availability_zones" {
  type = "list"
}

variable "bastion_instance_type" {
  type = "string"
}

variable "name_prefix" {
  type = "string"
  description = "AWS Name prefix identifier. Eg: asoorm:"
}
