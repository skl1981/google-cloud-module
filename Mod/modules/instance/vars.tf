variable student_name {
  default = "vgulinskiy"
}
variable student_id {
  type    = number
  default = 12
}
variable "name1" {
  default = "jump-server"
}
variable "machine_type" {
  default = "custom-1-4608"
}
variable "zone" {
  default = "us-central1-b"
}
variable "zone1" {
  default = "us-central1-c"
}
variable "image" {
  default = "centos-cloud/centos-7"
}
variable "type" {
  default = "pd-ssd"
}
variable "size" {
  type    = number
  default = "35"
}

variable "subnet_public_name" {
  default = "public"
}
variable "name" {
  default = "web-server"
}
variable "network" {
  default = "default"
}
