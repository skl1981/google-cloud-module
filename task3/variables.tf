variable "project" {
	type = string
}

variable "region" {
	type = string
}

variable "zone" {
	type = string
}

variable "machine_type" {
	type = string
}

variable "disk_size" {
	type = string
}

variable "disk_type" {
	type = string
}

variable "student_name" {
	type = string
}

variable "external_ports" {
	type = list
}

variable "external_ranges" {
	type = list
}

variable "internal_ports" {
	type = list
}

variable "internal_ranges" {
	type = list
}

variable "public_subnet" {
	type = string
}

variable "private_subnet" {
	type = string
}
