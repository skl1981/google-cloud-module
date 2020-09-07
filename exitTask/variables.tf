variable "project" {}

variable "region" {}

variable "zone" {}

variable "machine_type" {}

variable "disk_size" {}

variable "disk_type" {}

variable "ssh_key" {}

variable "images" {}

variable "student_name" {}

variable "external_ranges" {
	type = list
}

variable "external_http_ports" {
	type = list 
}

variable "ssh_external_ports" {
	type = list 
}

variable "internal_db_ports" {
	type = list
}

variable "internal_ranges" {
	type = list
}

variable "public_subnet" {}

variable "private_subnet" {}

variable "subnetwork_custom_public" {}

variable "subnetwork_custom_private" {}

variable "network_custom_vpc" {}

variable "web_tags" {
	type    = list
}

variable "external_ssh_tags" {
	type    = list
}

variable "db_tags" {
	type    = list
}

variable "distribution_zones" {
	type    = list
}

variable "http_port" {}

variable "db_replicas" {}

variable "web_replicas" {}

variable "db_port" {}

variable "tcp_lb_ports" {
	type = list
}

variable "ssh_user" {}

