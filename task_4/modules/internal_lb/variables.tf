variable "ig_name" {
  default = "db-instance-group"
}
variable "name" {
  default = "db"
}
variable "network" {
  default = "vpc"
}
variable "subnet" {
  default = "private"
}
variable "lb_health_check_port" {
  default = "5432"
}
variable "balanced_ports" {
  default = ["5432"]
}
variable "http_health_check" {
  default = false
}
variable "firewall_rule_hc" {
  default = false
}