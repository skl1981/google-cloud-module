/*variable "project" {}
variable "region" {}*/

variable "proxy-name" {}
variable "backend-service-name" {}
variable "urlmap-name" {}
variable "gfr-name" {}
variable "health-check-name" {}
variable "instance-group" {
  default = ""
}
variable "dependences" {
  type = list
  default = []
}

