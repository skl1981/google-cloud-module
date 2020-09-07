variable "project" {
	default = "compact-retina-288017"
}

variable "region" {
	default = "us-central1"
}

variable "zone" {
	default = "us-central1-c"
}

variable "machine_type" {
	default = "custom-1-4608"
}

variable "disk_size" {
	default = 35
}

variable "student_name" {
	default = "dkramich"
}

variable "network_custom_vpc" {
	default = "default"
}

variable "subnetwork_custom_public" {
	default = "default"
}

variable "disk_type" {
	default = "pd-ssd"
}

variable "images" {
	default = "centos-cloud/centos-7" 
}

variable "ssh_key" {
  default = ""
}

variable "ssh_user" {
  default = ""
}
