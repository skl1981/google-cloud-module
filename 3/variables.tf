variable "project" {
  description = "project variable"
}

variable "region" {
  default = "region"
}

variable "student_name" {}

variable "external-ports" {
  type = list
  default = ["1", "2"]
}

variable "student_IDnum" {
  default = 11
}

variable "zone" {}
variable "image" {}
variable "size" {}
variable "type" {}