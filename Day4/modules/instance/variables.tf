variable "name" {
description = "instance name" 
default = "bastion"
} 
variable "instance_template" {
description = "instance_template" 
default = "instance_template"
}
variable "network_name"{
description = "network name"
default = "nrabeichykava-vpc"
}
variable "subnetwork_name" {
description = "subnetwork name" 
default = "public"
}
variable "zone" {
description = "instance zone" 
default = "us-central1-a"
}
variable "script" {
description = "startup script for instance"
default = ""
}
variable "tags" {
  type = list
  default = ["bastion"]
}
variable "metadata"{
  type = map
  description = "metadata for instance"
  default = {}
}
variable "name_prefix" {
description = "name prefix for template"
default = "instance-template"
}
variable "machine_type" {
description = "instance machine_type"
default = "custom-1-4608-ext"
}
variable "region" {
description = "instance region"
default = "us-central1"
}
variable "image"{
description = "instance image"
default = "centos-cloud/centos-7"
}
variable "disk_size_gb" {
  description = "size of disk"
  type = number
  default = "35"
}
variable "disk_type"{
description = "type of disk"
default = "pd-ssd"
}
variable "target_tags" {
  type = list
  default = ["bastion"]
}
variable "source_tags" {
  type = list
  default = ["bastion"]
}
