variable "projectname" {
  default = "my-first-lab-project1"
}
variable "region" {
  default = "us-central1"
}
variable "tcp-port" {
  default = "5432"
}
variable "forwarding-rule-ports" {
  type    = list
  default = ["5432"]
}
variable "internal-mig" {
  default = ""
}
variable "network-name" {
  default = "default"
}
variable "sub-network-int-name" {
  default = "default"
}
