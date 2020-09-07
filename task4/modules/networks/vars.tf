variable "project_id"     {
  default  = "vladimir-project-01"
  type     = string
}
variable "region"         {
  default  = "us-central1"
  type     = string
}
variable "zone"           {
  default  = "us-central1-c"
  type     = string
}
variable "net_name"       {
  default  = "vladimir-sakhonchik"
  type     = string
}
variable "sub_priv_name"  {
  default  = "private-subnetwork"
  type     = string
}
variable "sub_pub_name"   {
  default  = "public-subnetwork"
  type     = string
}
variable "sub_priv_range" {
  default  = "10.13.2.0/24"
  type     = string
}
variable "sub_pub_range"  {
  default  = "10.13.1.0/24"
  type     = string
}
variable "jump_ports"     {
  default  = ["22"]
  type     = list
}
variable "web_ports"      {
  default  = ["22", "80"]
  type     = list
}
variable "db_ports"       {
  default  = ["22", "5432"]
  type     = list
}
