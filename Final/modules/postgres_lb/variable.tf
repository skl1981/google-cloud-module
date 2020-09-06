variable "fr_name" {
    default = "postgres-forwarding-rule"
}
variable "fr_scheme" {
    default = "INTERNAL"
}
variable "fr_ports" {
    default = [ "5432" ]
}
variable "network" {
    default = "my-vpc"
}
variable "subnet" {
    default = "private-subnet"
}
variable "backend_name" {
    default = "postgres-backend-service"
}
variable "backend_protocol" {
    default = "TCP"
}
variable "backend_to" {
    default = 10
}
variable "backend_sa" {
    default = "NONE"
}
variable "backend_group" {}
variable "hc_name" {
    default = "postgres-healthcheck"
}
variable "hc_interval" {
    default = 5
}
variable "hc_timeout" {
    default = 5
}
variable "hc_port" {
    default = "5432"
}

