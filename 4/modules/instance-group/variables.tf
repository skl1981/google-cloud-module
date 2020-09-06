variable "my_name" {}
variable "my_surname" {}

#variable "project" {}

variable "multi-zones" {
  type = list
}
variable "region" {}
variable "image" {}
variable "sub-public-name" {}
variable "machine-type" {}
variable "nginx-instance-prefix" {}
variable "group-manager-nginx-name" {}
variable "base-instance-name-n" {}
variable "base-instance-name-p" {}
variable "nginx-autoscaler-name" {}

# plus postgres vars
variable "postgres-instance-prefix" {}
variable "sub-private-name" {}
variable "group-manager-postgres-name" {}

variable "ssh-user" {}
variable "ssh-keys" {}

variable "ext-tags" {
  type = list
}

variable "dependences" {
  type = list
  default = []
}