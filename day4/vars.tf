variable "projectname" {
  default = "my-first-lab-project1"
}
variable "region" {
  default = "us-central1"
}

#>>>>>>> net vars
variable "new-name-net" {
  default = "exit-sshevtsov-vpc"
}
variable "publicip" {
  default = "10.109.1.0/24"
}
variable "public-sub-net" {
  default = "exit-public-sub-net"
}
variable "privatip" {
  default = "10.109.2.0/24"
}
variable "privat-sub-net" {
  default = "exit-privat-sub-net"
}
variable "ext-port" {
  type    = list
  default = ["80", "22"]
}

variable "all-port" {
  type    = list
  default = ["0-65535"]
}


#>>>>>> instance vars
variable "machinetype" {
  default = "n1-standard-1"
}
variable "image" {
  default = "centos-cloud/centos-7"
}
variable "hdd-size" {
  default = "20"
}
variable "hdd-type" {
  default = "pd-ssd"
}


#>>>>>>> mig vars
variable "site-image" {
  default = "centos-cloud/centos-7"
}
variable "policy-zone" {
  type    = list
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
variable "site-target-size" {
  default = "2"
}
variable "db-target-size" {
  default = "3"
}


#>>>>>>> http_lb vars
variable "http-port" {
  default = "80"
}


#>>>>>> internal_lb vars
variable "tcp-port" {
  default = "5432"
}
variable "forwarding-rule-ports" {
  type    = list
  default = ["5432"]
}
