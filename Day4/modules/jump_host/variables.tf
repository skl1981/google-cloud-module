variable "mod_jump_host_name" {
    type = string
}

variable "mod_jump_host_type" {
    type = string
}

variable "mod_jump_host_zone" {
    type = string
}

variable "mod_jump_host_image" {
    type = string
}

variable "mod_jump_host_network_interface" {
    type = string
}

variable "mod_jump_host_subnetwork" {
    type = string
}

variable "mod_jump_host_tags" {
    type = string
}

variable "ssh_key" {
  default = ""
}

variable "ssh_user" {
  default = ""
}