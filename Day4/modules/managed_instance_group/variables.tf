variable "target_autoscaler"{
default = "web"
}
variable "zone"{
default = "us-central1-b"
}
variable "group_name"{
default = "web"
}
variable "region"{
default ="us-central1"
} 
variable "distribution_policy_zones"{
type = list
default = ["us-central1-a", "us-central1-b", "us-central1-c"]
} 
variable "instance_template"{
default ="instance_template"
}  
variable "target_size"{
type = number 
default =1
} 
variable "metadata"{
default =""
}
variable "script"{
default =""
}
variable "tags" {
  type = list
  default = ["web"]
}
variable "subnetwork_name"{
  default ="public"
}
variable "named_ports" {	
  description = "Named name and named port"
  type = list(object({
  name = string
  port = number
  }))
  default = [
    {
      name = "http"
      port = 80
    }
  ]
}
variable "base_instance_name"{
default = "web"
}
variable "autoscaler"{
  type = bool
  default = false
}
variable "name_prefix" {
description = "name prefix for template"
default = "instance-template"
}
variable "machine_type" {
description = "instance machine_type"
default = "custom-1-4608-ext"
}
variable "image"{
description = "instance image"
default = "centos-cloud/centos-7"
}
variable "disk_size_gb" {
  description = "size of disk"
  type = number
  default = "35"
}
variable "disk_type"{
description = "type of disk"
default = "pd-ssd"
}
