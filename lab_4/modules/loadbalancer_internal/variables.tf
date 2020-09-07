variable "instancegroup_name" {
  default = "db-instance-group"
}
variable "prefix" {
  default = "db"
}
variable "network" {
  default = "vpc-net"
}
variable "subnet" {
  default = "vpc-net-private"
}
variable "db_server_healthcheck_port" {
  default = "5432"
}
variable "balancing_ports" {
  default = ["5432"]
}
variable "balancing_scheme" {
  default = "INTERNAL"
}