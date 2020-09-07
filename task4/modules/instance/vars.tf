variable "project_id" {
  default     = "vladimir-project-01"
  type        = string
}
variable "region" {
  default     = "us-central1"
  type        = string
}
variable "zone" {
  default     = "us-central1-c"
  type        = string
}
variable "name_instance" {
  default     = "jump-host"
  type        = string
}
variable "machine_type" {
  default     = "custom-1-4608"
  type        = string
}
variable "image_project" {
  default     = "debian-cloud"
  type        = string
}
variable "image_family" {
  default     = "debian-9"
  type        = string
}
variable "disk_type" {
  default     = "pd-ssd"
  type        = string
}
variable "disk_size_gb" {
  default     = "20"
  type        = string
}
variable "net_name"       {
  default     = "vladimir-sakhonchik"
  type        = string
}
variable "sub_pub_name"   {
  default     = "public-subnetwork"
  type        = string
}