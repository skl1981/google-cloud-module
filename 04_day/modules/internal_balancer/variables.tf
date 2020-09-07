/*variable "project_id" {
  type        = string
}
variable "region" {
  type        = string
}*/
variable "net_for_lb" {
  type        = string
}
variable "subnet_for_lb" {
  type        = string
}
variable "lb_proxy_port" {
  type        = list
}
variable "ins_group_name" {
  type        = string
  default     = "dbserver-igm"
}
variable "name" {
  type        = string
  default     = "internal-lb"
}
variable "lb_hc_port" {
  type        = string
  default     = "5432"
}
