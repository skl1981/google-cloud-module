variable "name" {
default = "db"
}
variable "health_check_port"{
  type = number  
  default = "5432"
} 
variable "protocol" {
default = "TCP"
}
variable "ports" {
  type = list
  default = [5432]
}
variable "ip_address" {
default = null
}
variable "destination_ranges"{
  type = list
  default = ["10.8.2.5/24"]
}
variable "source_tags"{
  type = list
  default = ["web"]
}
variable "target_tags"{
  type = list
  default = ["db"]
}
variable "network"{
default = "nrabeichykava-vpc"
}
variable "subnetwork"{
default = "private"
}
variable "group_name"{
default = "https://www.googleapis.com/compute/v1/projects/devops-lab-2020/regions/us-central1/instanceGroups/db"
}
