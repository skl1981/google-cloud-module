variable "mod_db_template_prefix" {
    type = string
}

variable "mod_db_template_type" {
    type = string
}

variable "mod_db_template_image" {
    type = string
}

variable "mod_db_template_tags" {
    type = string
}

variable "mod_db_template_network_interface" {
    type = string
}

variable "mod_db_template_subnetwork" {
    type = string
}

variable "mod_db_mig_name" {
    type = string
}

variable "mod_db_mig_region" {
    type = string
}

variable "mod_db_mig_base_name" {
    type = string
}

variable "mod_db_mig_zone_a" {
    type = string
}

variable "mod_db_mig_zone_b" {
    type = string
}

variable "mod_db_mig_zone_c" {
    type = string
}

variable "mod_db_mig_target_size" {
    type = number
}

variable "ssh_key" {
  default = ""
}

variable "ssh_user" {
  default = ""
}