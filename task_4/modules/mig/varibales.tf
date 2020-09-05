variable "region" {
  default = "us-central1"
}
variable "name" {
  default = "web"
}
variable "machine_type" {
  default = "f1-micro"
}
variable "network" {
  default = "vpc"
}
variable "subnetwork" {
  default = "public"
}
variable "image_project" {
  default = "centos-cloud"
}
variable "image_family" {
  default = "centos-7"
}
variable "distribution_zones" {
  type    = list
  default = ["us-central1-b"]
}
variable "instance_count" {
  default = "1"
}
variable "ig_health_check_port" {
  default = "80"
}
variable "hc_timeout_sec" {
  default = "3"
}
variable "hc_check_interval_sec" {
  default = "5"
}
variable "hc_healthy_threshold" {
  default = "2"
}
variable "hc_unhealthy_threshold" {
  default = "3"
}
variable "startup_script" {
  default = ""
}
variable "ssh_key" {
  default = ""
}
variable "ext_ip" {
  default = false
}
variable "http_health_check" {
  default = false
}
variable "firewall_rule_hc" {
  default = false
}
