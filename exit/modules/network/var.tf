variable "project_id"     {
  default = "weighty-forest-288021"
}
variable "region"         {
  default = "us-central1"
}
variable "zone"           {
  default = "us-central1-c"
}
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
  type = list
  default = ["22"]
}
variable "web_ports"      {
  type = list
  default = ["22","80"]
}
variable "db_ports"       {
  type = list
  default = ["22","5432"]
}