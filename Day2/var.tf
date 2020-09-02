variable "name" {}

variable "machine_type" {}

variable "disk_size" {
  type = number
}

variable "disk_type" {}

variable "image" {}

variable "tag" {
  type = list
}

variable "labels" {
  type = map
}

variable "delete" {
  type = bool
}

variable "network" {}
