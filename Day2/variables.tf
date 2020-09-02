variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "tags" {
    type = list
} 
variable "image"{}
variable "labels" {
    type = map
}
variable "size" {
    type = number
}
variable "disk_type"{}
variable "deletion" {} 
variable "script" {}
variable "network" {}
