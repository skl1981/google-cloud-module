/*variable "project" {}
variable "region" {}*/

variable "student-name" {}
variable "zone" {}
variable "image" {}
variable "size" {}
variable "type" {}
variable "sub-public-name" {}
variable "machine-type" {}
variable "tag-p22" {
  type = list
}

variable "ssh-user" {}
variable "ssh-keys" {}

variable "dependences" {
  type = list
  default = []
}
