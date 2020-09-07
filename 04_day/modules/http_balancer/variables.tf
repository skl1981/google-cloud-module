/*variable "project_id" {
  type        = string
}
variable "region" {
  type        = string
}*/
variable "ins_group_name" {
  type        = string
  default     = "webserver-igm"
}
variable "name" {
  type        = string
  default     = "http-lb"
}
variable "lb_proxy_port" {
  type        = string
  default     = "80"
}
variable "lb_proxy_port_name" {
  type        = string
  default     = "http"
}
variable "lb_hc_port" {
  type        = string
  default     = "80"
}
variable "lb_protocol" {
  type        = string
  default     = "HTTP"
}