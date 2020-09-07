variable "project" {
  default = "main-tokenizer-287910"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "prefix" {
  default = "kkarpau"
}
variable "machine_type" {
  default = "f1-micro"
}
variable "image_project" {
  default = "centos-cloud"
}
variable "image_family" {
  default = "centos-7"
}

#--- network
variable "vpc_net" {
  default = "vpc-net"
}
#--- external
variable "net_external_allow_protocol" {
  default = "tcp"
}
variable "net_external_allow_ports" {
  type    = list
  default = ["22"]
}
variable "net_external_source_ranges" {
  type    = list
  default = ["0.0.0.0/0"]
}
#--- internal
variable "net_internal_allow_protocol_t" {
  default = "tcp"
}
variable "net_internal_allow_protocol_u" {
  default = "udp"
}
variable "net_internal_allow_protocol_a" {
  default = "icmp"
}
variable "net_internal_allow_ports_t" {
  type    = list
  default = ["0-65535"]  
}
variable "net_internal_allow_ports_u" {
  type    = list
  default = ["0-65535"]
}
variable "net_internal_source_ranges" {
  type    = list
  default = ["10.6.0.0/16"] 
}

#--- subnets
variable "subnet_public_name" {
  default = "vpc-net-public"
}
variable "subnet_public_ip_cidr_range" {
  default = "10.6.1.0/24"
}
variable "subnet_private_name" {
  default = "vpc-net-private"
}
variable "subnet_private_ip_cidr_range" {
  default = "10.6.2.0/24"
}

#---  jumphost
variable "net_jumphost_allow_protocol" {
  default = "tcp"
}
variable "net_jumphost_allow_ports" {
  type    = list
  default = ["22"]
}
variable "net_jumphost_tags" {
  type    = list
  default = ["jumphost"]
}

#--- health-check
variable "net_healthcheck_allow_protocol" {
  default = "tcp"
}
variable "net_healthcheck_allow_ports" {
  type    = list
  default = ["22"]
}
variable "net_healthcheck_source_ranges" {
  type    = list
  default = ["130.211.0.0/22", "35.191.0.0/16"] 
}

#--- cloud nat
variable "nat_auto_ip" {
  default = "AUTO_ONLY"
}
variable "nat_all_ip_range" {
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "ssh_key" {
  default = ""
}