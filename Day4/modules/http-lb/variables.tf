variable "app_name"{
default = "app"
}
variable "group_name"{
default = "https://www.googleapis.com/compute/v1/projects/devops-lab-2020/regions/us-central1/instanceGroups/web"
}
variable "target_tags"{
  type = list
  default = ["web"]
}
variable "source_ranges"{
  type = list
  default = [""]
}
variable "network_name"{
default = "nrabeichykava-vpc"
}
