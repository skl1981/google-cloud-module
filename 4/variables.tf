#---------------------
#     GENERAL
#---------------------
variable "project" {}
variable "region" {}
variable "zone" {}
variable "multi-zones" {
  type = list
}

variable "student_name" {}
variable "my_name" {}
variable "my_surname" {}
variable "student_IDnum" {}

variable "image" {}
variable "machine-type" {}

variable "ssh-user" {}
variable "ssh-keys" {}


#---------------------
#     NETWORK
#---------------------
#firewall vars
variable "port-80" {
  type = list
}
variable "port-22" {
  type = list
}
variable "internal-ports" {
  type = list
}
variable "tag-ext-80" {
  type = list
}
variable "tag-ext-22" {
  type = list
}
variable "all-source-ranges" {
  type = list
}
variable "fw-ext-p80-name" {}
variable "fw-ext-p22-name" {}
variable "fw-int-name" {}
#-------------

#subnets vars
variable "sub-public-name" {}
variable "sub-private-name" {}
#-------------

#fw rules for healthcheck
variable "hc-source-ranges" {
  type = list
}
variable "port-5432" {
  type = list
}
variable "fw-ext-lb-name" {}
variable "fw-int-lb-name" {}
#-------------------------


#---------------------
#     JUMPHOST
#---------------------
variable "size" {}
variable "type" {}
variable "tag-p22" {
  type = list
}


#---------------------
#     INSTANCE GROUP
#---------------------
variable "nginx-instance-prefix" {}
variable "group-manager-nginx-name" {}
variable "base-instance-name-n" {}
variable "base-instance-name-p" {}
variable "nginx-autoscaler-name" {}
variable "postgres-instance-prefix" {}
variable "group-manager-postgres-name" {}
variable "ext-tags" {
  type = list
}


#---------------------
#     HTTP LB
#---------------------
variable "proxy-name" {}
variable "backend-service-name" {}
variable "urlmap-name" {}
variable "gfr-name" {}
variable "health-check-name" {}


#---------------------
#     INTERNAL LB
#---------------------
variable "fr-name" {}
variable "region-backend-service-name" {}
variable "int-health-check-name" {}

#---------------------
#     CLOUD NAT
#---------------------
variable "cloud-router-name" {}
variable "cloud-nat-name" {}
