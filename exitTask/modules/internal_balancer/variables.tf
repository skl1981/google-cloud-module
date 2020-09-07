variable "project" {
	default = "compact-retina-288017"
}

variable "region" {
	default = "us-central1"
}

variable "student_name" {
	default = "dkramich"
}

variable "db_port" {
	default = "5432"
}

variable "tcp_lb_ports" {
	type = list
	default = ["5432"]
}

variable "network_custom_vpc" {
	default = "default"
}

variable "subnetwork_custom_private" {
	default = "default"
}