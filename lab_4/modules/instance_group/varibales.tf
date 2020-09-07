variable "region" {
  default = "us-central1"
}
variable "machine_type" {
  default = "f1-micro"
}
variable "student_name" {
  default  = "Kanstantsin"
}
variable "student_surname" {
  default  = "Karpau"
}
variable "image_project" {
  default = "centos-cloud"
}
variable "image_family" {
  default = "centos-7"
}

variable "prefix_web" {
  default = "web"
}
variable "prefix_db" {
  default = "db"
}
variable "network" {
  default = "vpc-net"
}
variable "web_subnetwork" {
  default = "vpc-net-public"
}
variable "web_instance_count" {
  default = "1"
}
variable "web_healthckeck_instancegroup_port" {
  default = "80"
}
variable "web_healthckeck_timeout_sec" {
  default = "3"
}
variable "web_healthckeck_check_interval_sec" {
  default = "5"
}
variable "web_healthckeck_healthy_threshold" {
  default = "2"
}
variable "web_healthckeck_unhealthy_threshold" {
  default = "6"
}
variable "web_startup_script" {
  default = "run_web.sh"
}
variable "web_a_heal_policies_delay_sec" {
  default = "300"
}


variable "db_startup_script" {
  default = "run_db.sh"
}
variable "db_instance_count" {
  default = "3"
}
variable "db_subnetwork" {
  default = "vpc-net-private"
}
variable "db_healthckeck_instancegroup_port" {
  default = "5432"
}
variable "db_healthckeck_timeout_sec" {
  default = "1"
}
variable "db_healthckeck_check_interval_sec" {
  default = "1"
}
variable "db_a_heal_policies_delay_sec" {
  default = "3000"
}
variable "ssh_key" {
  default = ""
}
