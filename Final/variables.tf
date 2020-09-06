variable "app_project" {
  type = string
  description = "GCP project name"
}

variable "gcp_user" {
  type = string
  description = "GCP user name"
}

variable "gcp_key" {
  type = string
  description = "GCP public key"
}

variable "app_name" {
  type = string
  description = "Application name"
}

variable "gcp_region_1" {
  type = string
  description = "GCP region"
}

variable "gcp_zone_1" {
  type = string
  description = "GCP zone"
}

variable "private_subnet_cidr_1" {
  type = string
  description = "private subnet CIDR 1"
}

variable "private_subnet_cidr_2" {
  type = string
  description = "private subnet CIDR 2"
}
