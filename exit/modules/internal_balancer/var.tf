variable "project_id" {
  default = "weighty-forest-288021"
}
variable "region" {
  default = "us-central1"
}
variable "net_int_lb" {
  default = "mikita-shnipau"
}
variable "subnet_int_lb" {
  default = "private-subnetwork"
}
variable "ports_int_lb" {
  type    = list
  default = ["5432"]
}