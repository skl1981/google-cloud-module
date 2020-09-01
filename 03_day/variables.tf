variable "project_id" {
  type        = string
  default     = "my-day02-project"
}
variable "region" {
  type        = string
  default     = "us-central1"
}
variable "zone" {
  type        = string
  default     = "us-central1-a"
}
variable "student_name" {
  type        = string
  default     = "siarhei-hryshchanka"
}
variable "student_IDnum" {
  type        = string
  default     = "10"
}
variable "name_instance" {
  type        = string
  default     = "siarhei-hryshchanka-nginx"
}
variable "machine_type" {
  type        = string
  default     = "custom-1-4608"
}
variable "image_project" {
  type        = string
  default = "centos-cloud"
}
variable "image_family" {
  type        = string
  default = "centos-7"
}
variable "disk_type" {
  type        = string
  default = "pd-ssd"
}
variable "disk_size_gb" {
  type        = string
  default = 35
}