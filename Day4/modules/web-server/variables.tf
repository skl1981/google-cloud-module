variable "mod_studentName" {
    type = string
}

variable "mod_studentSurname" {
    type = string
}

variable "mod_nginx_template_prefix" {
    type = string
}

variable "mod_nginx_template_type" {
    type = string
}

variable "mod_nginx_template_image" {
    type = string
}

variable "mod_nginx_template_tags" {
    type = string
}

variable "mod_nginx_template_network_interface" {
    type = string
}

variable "mod_nginx_template_subnetwork" {
    type = string
}

variable "mod_nginx_mig_name" {
    type = string
}

variable "mod_nginx_mig_region" {
    type = string
}

variable "mod_nginx_mig_base_name" {
    type = string
}

variable "mod_nginx_mig_zone_a" {
    type = string
}

variable "mod_nginx_mig_zone_b" {
    type = string
}

variable "mod_nginx_mig_zone_c" {
    type = string
}

variable "mod_nginx_mig_target_size" {
    type = number
}

variable "mod_nginx_scaler_name" {
    type = string
}

variable "mod_nginx_scaler_min_rep" {
    type = number
}

variable "mod_nginx_scaler_max_rep" {
    type = number
}

variable "mod_nginx_scaler_cool_per" {
    type = number
}

variable "mod_nginx_scaler_target" {
    type = number
}

variable "ssh_key" {
  default = ""
}

variable "ssh_user" {
  default = ""
}