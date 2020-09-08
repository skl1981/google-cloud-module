variable "project_id" {
  default = "weighty-forest-288021"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}
variable "name_instance" {
  default = "jump-host"
}
variable "machine_type" {
  default = "custom-1-4608"
}
variable "image_project" {
  default = "centos-cloud"
}
variable "image_family" {
  default = "centos-7"
}
variable "disk_type" {
  default = "pd-ssd"
}
variable "disk_size_gb" {
  default = "20"
}
variable "net_name"       {
  default = "public-subnetwork"
}
variable "public_sub_name"   {
  default = "mikita-shnipau"
}