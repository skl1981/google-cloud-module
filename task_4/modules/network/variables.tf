variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "name" {
  default = "imelnik1"
}
variable "network" {
  default = "vpc"
}
variable "public_subnet_name" {
  default = "public"
}
variable "public_subnet_cidr" {
  default = "10.4.1.0/24"
}
variable "private_subnet_name" {
  default = "private"
}
variable "private_subnet_cidr" {
  default = "10.4.2.0/24"
}
variable "create_bastion" {
  default = true
}
variable "machine_type" {
  default = "f1-micro"
}
variable "bastion_tags" {
  type    = list
  default = ["bastion"]
}
variable "image_project" {
  default = "centos-cloud"
}
variable "image_family" {
  default = "centos-7"
}
variable "ssh_key" {
  default = ""
}
variable "allow_external" {
  type = map
  default = {
    allow_ports   = ["22"]
    source_ranges = ["0.0.0.0/0"]
  }
}
variable "allow_internal" {
  type = map
  default = {
    allow_ports   = ["0-65535"]
    source_ranges = ["10.4.0.0/16"]
  }
}
variable "allow_health_check" {
  default = true
}