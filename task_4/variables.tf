variable "project" {}
variable "region" {}
variable "ssh_username" {}
variable "ssh_key" {}
variable "web_instance_startup_script" {}
variable "ig_db_name" {}
variable "http_health_check" {}
variable "db_instance_count" {}
variable "db_instance_startup_script" {}
variable "db_distribution_zones" {
  type = list
}
variable "db_health_check_port" {}
