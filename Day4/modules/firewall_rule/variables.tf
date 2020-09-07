// public firewall rule variables
variable "mod_firewall_network_name" {
    type = string
}
// protocols
variable "mod_firewall_protocol_tcp" {
    type = string
}

variable "mod_firewall_protocol_udp" {
    type = string
}

variable "mod_firewall_protocol_sctp" {
    type = string
}
// ports
variable "mod_firewall_ports_ssh" {
    type = list
}

variable "mod_firewall_ports_http" {
    type = list
}

variable "mod_firewall_ports_db" {
    type = list
}
// tags
variable "mod_firewall_tag_jump_host" {
    type = string
}

variable "mod_firewall_tag_web_server" {
    type = string
}

variable "mod_firewall_tag_database_server" {
    type = string
}
//------------------------------------------------------

// ssh firewall rule variables for jump-host
variable "mod_ingress_ssh_allow_jump_host_name" {
    type = string
}

variable "mod_ingress_ssh_jump_host_source_ranges" {
    type = list
}

variable "mod_ingress_ssh_deny_from_vms_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for vms
variable "mod_ingress_ssh_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for http
variable "mod_ingress_http_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for db
variable "mod_ingress_db_name" {
    type = string
}
//------------------------------------------------------