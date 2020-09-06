variable "project_id"     {
  type = string
}
variable "region"         {
  type = string
}
variable "zone"           {
  type = string
}



variable "net_name"       {
  type = string
}
variable "sub_priv_name"  {
  type = string
}
variable "sub_pub_name"   {
  type = string
}
variable "sub_priv_range" {
  type = string
}
variable "sub_pub_range"  {
  type = string
}
variable "jump_ports"     {
  type = list
}
variable "web_ports"      {
  type = list
}
variable "db_ports"       {
  type = list
}


variable "name_instance"  {
  type        = string
}
variable "machine_type"   {
  type        = string
}
variable "image_project"  {
  type        = string
}
variable "image_family"   {
  type        = string
}
variable "disk_type"      {
  type        = string
}
variable "disk_size_gb"   {
  type        = string
}


variable "base_inst_name_web" {
  type        = string
}
variable "count_ins_web"      {
  type        = string
}
variable "base_inst_name_db"  {
  type        = string
}
variable "count_ins_db"       { 
  type        = string
}
variable "student_name"       {
  type        = string
}
variable "student_surname"    {
  type        = string
}


variable "ports_int_lb" {
  type        = list
}

