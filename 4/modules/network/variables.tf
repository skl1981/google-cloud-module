#variable "project" {}
variable "region" {}

variable "student_name" {}
variable "student_IDnum" {}

#firewall vars
variable "port-80" {
  type = list
}
variable "port-22" {
  type = list
}
variable "internal-ports" {
  type = list
}
variable "tag-ext-80" {
  type = list
}
variable "tag-ext-22" {
  type = list
}
variable "all-source-ranges" {
  type = list
}
variable "fw-ext-p80-name" {}
variable "fw-ext-p22-name" {}
variable "fw-int-name" {}
#-------------

#subnets vars
variable "sub-public-name" {}
variable "sub-private-name" {}
#-------------

#fw rules for healthcheck
variable "hc-source-ranges" {
  type = list
}
variable "port-5432" {
  type = list
}
variable "fw-ext-lb-name" {}
variable "fw-int-lb-name" {}
#-------------------------


