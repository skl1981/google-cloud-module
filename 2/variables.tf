variable "project" {
}

variable "region" {
  default = "us-central1"
}

variable "name" {
  default = "nginx-terraform"
}

variable "machine_type" {
  default = "custom-1-4608"
}

variable "zone" {
  default = "us-central1-c"
}

variable "image" {
  default = "centos-cloud/centos-7"
}

variable "size" {
  default = "35"
}

variable "type" {
  default = "pd-ssd"
}

variable "network" {
  default = "default"
}

variable "labels" {
  type = map
}

variable "deletion_protection" {
  default = true
}

variable "tags" {
  type = list
}

