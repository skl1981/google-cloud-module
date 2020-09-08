variable "project_id"     {
  default = "weighty-forest-288021"
}
variable "region"         {
  default = "us-central1"
}
variable "zone"           {
  default = "us-central1-c"
}

/////////////
///network///
/////////////

variable "net_name"       {
  default = "mikita-shnipau"
}
variable "private_sub_name"  {
  default = "private-subnetwork"
}
variable "public_sub_name"   {
  default = "public-subnetwork"
}
variable "private_sub_range" {
  default = "10.7.2.0/24"
}
variable "public_sub_range"  {
  default = "10.7.1.0/24"
}
variable "jump_ports"     {
  type    = list
  default = ["22"]
}
variable "web_ports"      {
  type    = list
  default = ["22","80"]
}
variable "db_ports"       {
  type    = list
  default = ["22","5432"]
}

/////////////
///bastion///
/////////////

variable "name_instance"  {
  default = "jump-host"
}
variable "machine_type"   {
  default = "custom-1-4608"
}
variable "image_project"  {
  default = "centos-cloud"
}
variable "image_family"   {
  default = "centos-7"
}
variable "disk_type"      {
  default = "pd-ssd"
}
variable "disk_size_gb"   {
  default = "35"
}

////////////////////
///instance group///
////////////////////

variable "base_inst_name_web" {
  default = "web"
}
variable "count_ins_web"      {
  default = "1"
}
variable "base_inst_name_db"  {
  default = "db"
}
variable "count_ins_db"       { 
  default = "3"
}
variable "student_name"       {
  default = "Mikita"
}
variable "student_surname"    {
  default = "Shnipau"
}

//////////////
///balancer///
//////////////

variable "ports_int_lb" {
  type    = list
  default = ["5432"]
}
