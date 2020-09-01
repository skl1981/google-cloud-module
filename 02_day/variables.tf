variable "project_id" {
  type        = string
}
variable "region" {
  type        = string
}
variable "zone" {
  type        = string
}
variable "name_instance" {
  type        = string
}
variable "machine_type" {
  type        = string
}
variable "image_project" {
  type        = string
}
variable "image_family" {
  type        = string
}
variable "disk_type" {
  type        = string
}
variable "disk_size_gb" {
  type        = string
}
variable "tags" {
  type        = list
}
variable "labels" {
  type        = map
}
variable "delete" {
  type        = bool
}