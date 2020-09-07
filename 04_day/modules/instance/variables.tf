/*variable "project_id" {
  type        = string
}
variable "region" {
  type        = string
}
variable "zone" {
  type        = string
}*/
variable "tags"          { 
  type        = list
  default     = ["ssh-jump"]
}
variable "ssh_user_name"    {
  type        = string
  default     = "ubuntu"
}
variable "ssh_key_name"    {
  type        = string
  default     = "key.pub"
}
variable "name_instance" {
  type        = string
}
variable "machine_type" {
  type        = string
}
variable "image_jump" {
  type        = string
}
variable "disk_type" {
  type        = string
}
variable "disk_size_gb" {
  type        = string
}
variable "net_name"       {
  type = string
}
variable "sub_pub_name"   {
  type = string
}