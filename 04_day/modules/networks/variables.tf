/*variable "project_id"     {
  type = string
}
variable "zone"           {
  type = string
}*/
variable "region"         {
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
variable "allow_jump_ports"     {
  type = list
}
variable "allow_web_ports"      {
  type = list
}
variable "allow_db_ports"       {
  type = list
}
variable "target_tag_db"       {
  type = list
  default = ["db"]
}
variable "target_tag_web"       {
  type = list
  default = ["web"]
}
variable "target_tag_jump"       {
  type = list
  default = ["ssh-jump"]
}