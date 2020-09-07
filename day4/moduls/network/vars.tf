### vars for network modul
variable "projectname" {
  default = "my-first-lab-project1"
}
variable "region" {
  default = "us-central1"
}
variable "network-name" {
  default = "exit-sshevtsov-vpc"
}

variable "public-sub-net" {
  default = "exit-public-sub-net"
}

variable "publicip" {
  default = "10.109.1.0/24"
}

variable "privat-sub-net" {
  default = "exit-privat-sub-net"
}

variable "privatip" {
  default = "10.109.2.0/24"
}

variable "ext-port" {
  type    = list
  default = ["80", "22"]
}

variable "all-port" {
  type    = list
  default = ["0-65535"]
}

variable "internal-ip" {
  type    = list
  default = ["10.109.0.0/16"]
}
