variable "project" {
}

variable "name" {
}

variable "region" {
}

variable "zone" {
}

variable "image_family" {
}

variable "image_project" {
}

variable "machine_type" {
}

variable "boot_disk_type" {
}

variable "boot_disk_size" {
}

variable "deletion_protection" {
}

variable "tag" {
  type = list
  default     = []
}

variable "network" {
}

variable "label" {
  type = map
  default     = {}
}

variable "script" {
}

variable "service_account_email" {
}

variable "service_account_scope" {
  type = list
  default     = []
}


