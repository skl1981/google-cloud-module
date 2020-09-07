variable student_name {
description = "student name" 
}
variable network_range{
description = "network range of custom network for firewalls rule" 
}
variable subnetwork_range_public {
description = "public subnetwork of custom network" 
}
variable subnetwork_range_private {
description = "private subnetwork of custom network" 
}
variable subnetwork_name_public {
description = "name of public subnetwork" 
}
variable subnetwork_name_private {
description = "name of private subnetwork" 
}
variable region{
description = "region of subnetwork" 
}
variable "name_prefix" {
description = "name prefix for template" 
}
variable "machine_type" {
description = "instance machine_type" 
}
variable "image"{
description = "instance image" 
}
variable "disk_size_gb" {
    type = number
    description = "size of disk"
}
variable "disk_type"{
description = "type of disk"
}
variable "metadata"{
    type = map
    description = "metadata for instance"
}
variable "bastion_tags" {
    type = list
    description = "tags for bastion"
}
variable "bastion_zone"{
description = "bastion zone"
}
variable "name_bastion_instance" {
description = "name of bastion instance"
}
variable "web_group_name"{
description = "group name for web managed regional group"
}
variable "distribution_policy_zones"{
     type = list
     description = "zones for managed groups"
} 
#variable "web_target_pool"{
#} 
variable "web_target_size"{
     type = number
     description = "size of web managed regional group" 
} 
variable "web_script"{
description = "script for web instances"
}
variable "web_tags" {
    type = list
    description =  "tags for web instances"
}
variable "web_named_ports" {
    description = "named name and named port"
    type = list(object({
    name = string
    port = number
    }))
}
variable "web_base_instance_name"{
description = "base instance name for web managed regional group"
}
variable "db_base_instance_name"{
description = "base instance name for db managed regional group"
}
variable "db_group_name"{
description = "group name for db managed regional group"
}
#variable "db_target_pool"{
#}
variable "db_target_size"{
    type = number
    description = "size of db managed regional group"
}
variable "db_script"{
description = "script for db instances"
}
variable "db_tags" {
    type = list
    description = "tags for db instances"
}
variable "db_named_ports" {
    description = "named name and named port"
    type = list(object({
    name = string
    port = number
    }))
}
variable "app_name"{
description = "app name for load balancer"
}
variable "db_name" {
description = "db name for load balancer"
}
variable "health_check_port"{
    type = number
    description = "port for health check"  
} 
variable "protocol" {
    description = "protocol for health check"
}
variable "ports" {    
    type = list
    description = "ports for internal load-balancer"
}
variable "ip_address" {
    description = "ip address of the load balancer will be assigned automatically"
}
variable "autoscaler"{
    type = bool
    description = "enable autoscaler"
}
