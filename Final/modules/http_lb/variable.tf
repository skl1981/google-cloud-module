variable "gfr_name" {
    default = "global-forwarding-rule"
}
variable "gfr_port" {
    default = "80"
}
variable "proxy_name" {
    default = "proxy"
}
variable "url_map_name" {
    default = "load_balancer"
}
variable "backend_name" {
    default = "backend-service"
}
variable "backend_port_name" {
    default = "http"
}
variable "backend_protocol" {
    default = "HTTP"
}
variable "backend_group" {}
variable "backend_balancing_mode" {
    default = "RATE"
}
variable "backend_capacity" {
    default = 0.4
}
variable "backend_rpi" {
    default =50
}
variable "http_healthcheck_name" {
    default = "http-healthcheck"
}
variable "hc_timeout" {
    default = 1
}
variable "hc_interval" {
    default = 1
}
variable "hc_port" {
    default = 80
}