
variable "aws_region" {}
variable "identifier" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "port" {}
variable "db_name" {}
variable "username" {}
variable "password" {}
variable "maintenance_window" {}
variable "backup_window" {}
variable "family" {}
variable "deletion_protection" {}
variable "tags" {}
variable "vpc_cidr" {
  type = string
  default = "10.99.0.0/18"
  }
  
variable "private_subnets" {}
variable "public_subnets" {}
/* variable "engine" {}
variable "vpc_cidr" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {}
variable "engine" {} */