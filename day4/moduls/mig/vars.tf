variable "projectname" {
  default = "my-first-lab-project1"
}

variable "region" {
  default = "us-central1"
}
variable "machinetype" {
  default = "n1-standard-1"
}
variable "site-image" {
  default = "centos-cloud/centos-7"
}
variable "network-name" {
  default = "default"
}
variable "sub-network-ext-name" {
  default = "default"
}
variable "sub-network-int-name" {
  default = "default"
}
variable "policy-zone" {
  type    = list
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
variable "site-target-size" {
  default = "1"
}
variable "db-target-size" {
  default = "3"
}
