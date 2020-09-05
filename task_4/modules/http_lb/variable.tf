variable "ig_name" {
  default = "web-instance-group"
}
variable "name" {
  default = "web"
}
variable "network" {
  default = "vpc"
}
variable "lb_health_check_port" {
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
variable "firewall_rule_hc" {
  default = false
}
variable "http_health_check" {
  default = false
}