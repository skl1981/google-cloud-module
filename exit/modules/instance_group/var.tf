variable "project_id"			{
  default  = "weighty-forest-288021"
}
variable "region"			{
  default  = "us-central1"
}
variable "zone"			{
  default  = "us-central1-c"
}
variable "machine_type"			{
  default  = "n1-standard-1"
}
variable "image_family"		{
  default = "centos-7"
}
variable "image_project"			{
  default  = "centos-cloud"
}
variable "net_name"			{
  default  = "mikita-shnipau-vpc"
}
variable "subnet_for_web"			{
  default  = "public-subnetwork"
}
variable "base_inst_name_web"			{
  default  = "web"
}
variable "base_inst_name_db"			{
  default  = "db"
}
variable "count_ins_web"			{
  default  = "1"
}
variable "subnet_for_db"			{
  default  = "private-subnetwork"
}
variable "count_ins_db"			{
  default  = "3"
}
variable "student_name"			{
  default  = "Mikita"
}
variable "student_surname"			{
  default  = "Shnipau"
}
