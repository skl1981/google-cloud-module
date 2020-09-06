variable "network" {
    default = "my-vpc"
}

#firewall rules names
variable "fr_1_name" {
    default = "allow-ssh-internal"
}
variable "fr_2_name" {
    default = "allow-http"
}
variable "fr_3_name" {
    default = "allow-http-health-check"
}
variable "fr_4_name" {
    default = "allow-postgres-health-check"
}
variable "fr_5_name" {
    default = "allow-external-to-jump-host"
}
variable "fr_6_name" {
    default = "deny-ssh-internal"
}
variable "fr_7_name" {
    default = "allow-postgres"
}

#protocols
variable "icmp_prot" {
    default = "icmp"
}
variable "tcp_prot" {
    default = "tcp"
}
variable "udp_prot" {
    default = "udp"
}

#ports
variable "ssh_port" {
    default = "22"
}
variable "http_port" {
    default = "80"
}
variable "postgres_port" {
    default = "5432"
}

#tags
variable "tag_http" {
    default = "http"
}
variable "tag_postgres" {
    default = "postgres"
}
variable "tag_jump_host" {
    default = "jump-host"
}

#ranges
variable "health_ranges" {
    default = ["130.211.0.0/22","35.191.0.0/16"]
}
variable "all_ranges" {
    default = ["0.0.0.0/0"]
}
