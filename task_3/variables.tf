variable "project" {}

variable "region" {}

variable "zone" {}

variable "student_name" {}

variable "students_IDnum" {}
/*
variable "fw_config" {
  default = {
    internal = {
      allow_ports   = ["80", "22"]
      source_ranges = ["0.0.0.0/0"]
    }
    external = {
      allow_ports   = ["0-65535"]
      source_ranges = ["10.1.0.0/16"]
    }
  }
}
*/
variable "machine_type" {}

variable "image_project" {}

variable "image_family" {}
