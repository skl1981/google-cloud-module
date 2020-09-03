variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "name" {
  type = string
}

variable "delete" {
  type = bool
}

variable "type" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "disk_image" {
  type = string
}

variable "network_type" {
  type = string
}

variable "tags" {
  type = list
}

variable "labels" {
  type = map
}

variable "persistent_disk_name" {
  type = string
}

variable "persistent_disk_size" {
  type = string
}

variable "persistent_disk_type" {
  type = string
}
