// shared variables
variable "project_id"     {
  type = string
}
variable "region"         {
  type = string
}
variable "zone"           {
  type = string
}

// network variables
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

// bastion instance variables
variable "ssh_user_name"  {
  type        = string
}
variable "ssh_key_name"   {
  type        = string
}
variable "image_jump"     {
  type        = string
}
variable "name_instance"  {
  type        = string
}
variable "machine_type"   {
  type        = string
}
variable "disk_type"      {
  type        = string
}
variable "disk_size_gb"   {
  type        = string
}

// instance group variables
variable "machine_type_web" {
  type        = string
}
variable "machine_type_db" {
  type        = string
}
variable "image_web"  {
  type        = string
}
variable "image_db"   {
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
variable "web_script"    {
  type        = string
}
variable "db_script"    {
  type        = string
}
variable "ssh_user_name_for_groups"  {
  type        = string
}
variable "ssh_key_name_for_groups"   {
  type        = string
}


// http lb variables
variable "http_lb_proxy_port"    {
  type        = string
}
variable "http_lb_protocol"    {
  type        = string
}
variable "http_lb_hc_port"    {
  type        = string
}

// interanal lb variables
variable "internal_lb_proxy_port" {
  type        = list
}
variable "internal_lb_hc_port" {
  type        = string
}