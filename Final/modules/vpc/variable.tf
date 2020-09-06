variable "vpc_name" {
  type = string
  default = "my-vpc"
  description = "VPC name"
  
}
variable "ac_sub" {
  default = false
  description = "Auto create subnetworks"
}
variable "route_mod" {
    type = string
    default = "GLOBAL"
    description = "VPC routing mode"
}
variable "sub_name_1" {
  type = string
  default = "public-subnet"
  description = "Subnetwork name"
}
variable "sub_name_2" {
  type = string
  default = "private-subnet"
  description = "Subnetwork name"
}

variable "cidr_1" {
  type = string
  default = "10.10.10.0/24"
  description = "Subnetwork cidr"
}
variable "cidr_2" {
  type = string
  default = "10.10.20.0/24"
  description = "Subnetwork cidr"
}
variable "region" {
  type = string
  default = "us-central1"
}
variable "nat_ip_name"{
    default = "jump-host-nat-ip"
}
variable "project" {
  default = "smooth-era-287810"
}

