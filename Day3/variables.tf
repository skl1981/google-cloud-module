variable student_name {
description = "student name" 
}
variable network_range{
description = "network range of custom network for firewalls rule" 
}
variable public_subnetwork {
description = "public subnetwork of custom network" 
}
variable private_subnetwork {
description = "privet subnetwork of custom network" 
}
variable "name" {
description = "instance name" 
}
variable "machine_type" {
description = "instance machine_type" 
}
variable "zone" {
description = "instance zone" 
}
variable "image"{
description = "instance image" 
}
variable "size" {
    description = "size of disk"
    type = number
}
variable "disk_type"{
     description = "type of disk"
}


