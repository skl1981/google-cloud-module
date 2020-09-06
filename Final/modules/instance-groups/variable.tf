variable "autoscaler_name"{
    default = "nginx-autoscaler"
}
variable "region" {
    default = "us-central1"
}
variable "max_replicas" {
    default = 3
}
variable "min_replicas" {
    default = 1
}
variable "cooldown_period" {
    default = 60
}
variable "cpu_target" {
    default = 0.5
}


variable "nginx_igm_name" {
    default = "nginx-web"
}
variable "nginx_igm_base_name" {
    default = "web"
}
variable "nginx_igm_zones" {
    default = ["us-central1-a", "us-central1-b","us-central1-c"]
}
variable "nginx_igm_template" {}
variable "nginx_igm_named_port_name" {
    default = "http"
}
variable "nginx_igm_named_port_port" {
    default = 80
}

variable "postgres_igm_name" {
    default = "postgres"
}
variable "postgres_igm_base_name" {
    default = "postgres"
}
variable "postgres_igm_zones" {
    default = ["us-central1-a", "us-central1-b","us-central1-c"]
}
variable "postgres_igm_template" {}
variable "postgres_igm_target_size" {
    default = 3
}
variable "postgres_igm_named_port_name" {
    default = "postgres"
}
variable "postgres_igm_named_port_port" {
    default = 5432
}


