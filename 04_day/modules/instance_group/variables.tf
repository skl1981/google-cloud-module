/*variable "project_id"         { 
  type        = string
}
variable "zone"               { 
  type        = string
}*/
variable "region"             {
  type        = string
  default     = "us-central1"
}
variable "machine_type_db"    {
  default     = "n1-standard-1"
  type        = string
}
variable "machine_type_web"   {
  default     = "n1-standard-1"
  type        = string
}
variable "image_db"           {
  type        = string
}
variable "image_web"          {
  type        = string
}
variable "net_name"           { 
  type        = string
}
variable "subnet_for_web"     {
  type        = string
}
variable "subnet_for_db"      {
  type        = string
}
variable "base_inst_name_web" {
  type        = string
}
variable "base_inst_name_db"  {
  type        = string
}
variable "count_ins_web"      {
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
variable "web_ins_tags"       {
  type        = list
  default     = ["web"]
}
variable "db_ins_tags"        {
  type        = list
  default     = ["db"]
}
variable "web_name"           {
  type        = string
  default     = "webserver"
}
variable "db_name"            {
  type        = string
  default     = "dbserver"
}
variable "ssh_user_name"      {
  type        = string
  default     = "ubuntu"
}
variable "ssh_key_name"       {
  type        = string
  default     = "key.pub"
}
variable "web_script"         {
  type        = string
  default     = "script_web.sh.tpl"
}
variable "db_script"          {
  type        = string
  default     = "script_db.sh"
}
variable "db_hc_port"         {
  type        = string
  default     = "5432"
}
variable "web_hc_port"        {
  type        = string
  default     = "80"
}