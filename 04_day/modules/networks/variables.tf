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
