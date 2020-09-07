variable "vpc_name" {
    type = string
}

variable "vpc_auto_create_subnetworks" {
    type = bool
}

variable "ssh_user" {
    type = string
}

variable "ssh_key" {
    type = string
}

variable "subnetwork_names" {
    type = map
}

variable "subnetwork_ip_ranges" {
    type = map
}

variable "jump_host_name" {
    type = string
}

variable "jump_host_type" {
    type = string
}

variable "jump_host_zone" {
    type = string
}

variable "jump_host_image" {
    type = string
}

variable "jump_host_subnetwork" {
    type = string
}

variable "router_name" {
    type = string
}

variable "nat_name" {
    type = string
}

variable "nat_ip_option" {
    type = string
}

variable "nat_subnetwork_ip_ranges" {
    type = string
}

// public firewall rule variables
// protocols
variable "firewall_protocol_tcp" {
    type = string
}

variable "firewall_protocol_udp" {
    type = string
}

variable "firewall_protocol_sctp" {
    type = string
}
// ports
variable "firewall_ports_ssh" {
    type = list
}

variable "firewall_ports_http" {
    type = list
}

variable "firewall_ports_db" {
    type = list
}
// tags
variable "jump_host_tags" {
    type = string
}
variable "firewall_tag_web_server" {
    type = string
}

variable "firewall_tag_database_server" {
    type = string
}
//------------------------------------------------------

// ssh firewall rule variables for jump-host
variable "ingress_ssh_allow_jump_host_name" {
    type = string
}

variable "ingress_ssh_jump_host_source_ranges" {
    type = list
}

variable "ingress_ssh_deny_from_vms_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for vms
variable "ingress_ssh_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for http
variable "ingress_http_name" {
    type = string
}
//------------------------------------------------------

// firewall rule variable for db
variable "ingress_db_name" {
    type = string
}
//------------------------------------------------------

// web-server variables
variable "studentName" {
    type = string
}

variable "studentSurname" {
    type = string
}

variable "nginx_template_prefix" {
    type = string
}

variable "nginx_template_tags" {
    type = string
}

variable "nginx_mig_name" {
    type = string
}

variable "nginx_mig_zone_a" {
    type = string
}

variable "nginx_mig_zone_b" {
    type = string
}

variable "nginx_mig_zone_c" {
    type = string
}

variable "region" {
    type = string
}

variable "nginx_mig_target_size" {
    type = number
}

variable "nginx_scaler_name" {
    type = string
}

variable "nginx_scaler_min_rep" {
    type = number
}

variable "nginx_scaler_max_rep" {
    type = number
}

variable "nginx_scaler_cool_per" {
    type = number
}

variable "nginx_scaler_target" {
    type = number
}
//------------------------------------------------------

// database-server variables
variable "db_template_prefix" {
    type = string
}

variable "db_template_tags" {
    type = string
}

variable "db_host_subnetwork" {
    type = string
}

variable "db_mig_name" {
    type = string
}

variable "db_mig_target_size" {
    type = number
}
//------------------------------------------------------

// http LB variables
variable "http_lb_hc_name" {
    type = string
}

variable "http_lb_bk_name" {
    type = string
}

variable "http_lb_map_name" {
    type = string
}

variable "http_lb_proxy_name" {
    type = string
}

variable "http_lb_forw_rule_name" {
    type = string
}

variable "http_lb_forw_rule_port_range" {
    type = number
}
//------------------------------------------------------

// internal LB variables
variable "int_lb_hc_name" {
    type = string
}

variable "int_lb_hc_port" {
    type = string
}

variable "int_lb_bk_name" {
    type = string
}

variable "int_lb_forw_rule_name" {
    type = string
}

variable "int_lb_forw_rule_scheme" {
    type = string
}

variable "int_lb_forw_rule_ports" {
    type = list
}
//------------------------------------------------------
