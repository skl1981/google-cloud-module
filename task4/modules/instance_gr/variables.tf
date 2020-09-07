variable "project_id"         { 
  default = "vladimir-project-01"
  type        = string
}
variable "region"             {
  default     = "us-central1"
  type        = string
}
variable "zone"               {
  default     = "us-central1-c" 
  type        = string
}
variable "machine_type"       {
  default     = "n1-standard-1"
  type        = string
}
variable "image_project"      {
  default     = "debian-cloud"
  type        = string
}
variable "image_family"       {
  default     = "debian-9"
  type        = string
}
variable "net_name"           {
  default     = "vladimir-sakhonchik-vpc" 
  type        = string
}
variable "subnet_for_web"     {
  default     = "public-subnetwork"
  type        = string
}
variable "subnet_for_db"      {
  default     = "public-subnetwork"
  type        = string
}
variable "base_inst_name_web" {
  default     = "db"
  type        = string
}
variable "count_ins_web"      {
  default     = "1"
  type        = string
}
variable "base_inst_name_db"  {
  default     = "db"
  type        = string
}
variable "count_ins_db"       {
  default     = "3"
  type        = string
}
variable "student_name"       {
  default     = "Vladimir"
  type        = string
}
variable "student_surname"    {
  default     = "Sakhonchik"
  type        = string
}
