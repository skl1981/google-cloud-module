variable "project" {}

variable "region" {}

variable "zone" {}

variable "creation-way" {}

variable "network" {}

variable "allow_ports" {
  type = list
}

variable "network_tags" {
  type = list
}

variable "machine_type" {}

variable "image_project" {}

variable "image_family" {}

variable "disk_size_gb" {}

variable "labels" {
  type = map
}
variable "pd_size" {}
