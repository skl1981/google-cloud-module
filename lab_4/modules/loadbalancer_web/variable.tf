variable "instancegroup_name" {
  default = "instance-group-web"
}
variable "prefix" {
  default = "web"
}
variable "network" {
  default = "vpc-net"
}
variable "healthckeck_loadbalancer_port" {
  default = "80"
}
variable "healthckeck_timeout_sec" {
  default = "3"
}
variable "healthckeck_check_interval_sec" {
  default = "5"
}
variable "healthckeck_healthy_threshold" {
  default = "2"
}
variable "healthckeck_unhealthy_threshold" {
  default = "3"
}

variable "backend_service_port_name" {
  default = "http"
}
variable "backend_service_protocol" {
  default = "HTTP"
}
variable "backend_service_timeout_sec" {
  default = "10"
}
variable "backend_service_balancing_mode" {
  default = "RATE"
}
variable "backend_service_max_rate_per_instance" {
  default = "50"
}