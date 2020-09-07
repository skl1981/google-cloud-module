variable "project" {}
variable "region" {}
variable "zone" {}
variable "ssh_username" {}
variable "ssh_key" {}

variable "machine_type" {}
variable "image_project" {}
variable "image_family" {}

variable "prefix_web" {}
variable "prefix_db" {}
variable "web_instance_count" {}
variable "db_instance_count" {}
variable "student_name" {}
variable "student_surname" {}

variable "vpc_net_name" {}
variable "vpc_net_prefix" {}
variable "subnet_private_name" {}
variable "subnet_public_name" {}
variable "subnet_private_cidr" {}
variable "subnet_public_cidr" {}

variable "net_jumphost_ports" {
  type = list
}
variable "net_external_allow_ports" {
  type = list
}
variable "net_internal_allow_ports_t" {
  type = list
}
variable "balancing_ports" {
  type = list
}