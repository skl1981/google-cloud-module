variable "project_id" {
  default     = "vladimir-project-01"
  type        = string
}
variable "region" {
  default     = "us-central1"
  type        = string
}
variable "net_int_lb" {
  default     = "vladimir-sakhonchik"
  type        = string
}
variable "subnet_int_lb" {
  default     = "private-subnetwork" 
  type        = string
}
variable "ports_int_lb" {
  default     = ["5432"]
  type        = list
}