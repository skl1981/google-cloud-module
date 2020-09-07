// values and description variable in var.tfvars file 
provider "google" {
  project            = var.project_id 
  region             = var.region     
  zone               = var.zone       
}

// bucket for tfstate file
terraform {
  backend "gcs" {
    bucket = "shryshchnka"
    prefix = "terraform_data/"
  }
}


// create network infrastructure with nat cloud service
module "network" {
  source             = "./modules/networks"             
  region             =  var.region    
  net_name           =  var.net_name 
  sub_priv_name      =  var.sub_priv_name 
  sub_pub_name       =  var.sub_pub_name   
  sub_priv_range     =  var.sub_priv_range 
  sub_pub_range      =  var.sub_pub_range 
  allow_jump_ports   =  var.allow_jump_ports  
  allow_web_ports    =  var.allow_web_ports  
  allow_db_ports     =  var.allow_db_ports 
}


// create bastion instance
module "instance" {
  source             = "./modules/instance"
  name_instance      =  var.name_instance 
  machine_type       =  var.machine_type 
  image_jump         =  var.image_jump
  disk_type          =  var.disk_type 
  disk_size_gb       =  var.disk_size_gb 
  net_name           =  module.network.network-name
  sub_pub_name       =  module.network.subnetwork-name-public
  ssh_user_name      =  var.ssh_user_name
  ssh_key_name       =  var.ssh_key_name
  depends_on         = [module.network]
}

// create web and db group instance
module "instance_group" {
  source             = "./modules/instance_group"
  machine_type_db    =  var.machine_type_db
  machine_type_web   =  var.machine_type_web
  image_db           =  var.image_db
  image_web          =  var.image_web 
  base_inst_name_db  =  var.base_inst_name_db 
  base_inst_name_web =  var.base_inst_name_web 
  count_ins_db       =  var.count_ins_db
  count_ins_web      =  var.count_ins_web 
  student_name       =  var.student_name
  student_surname    =  var.student_surname
  ssh_user_name      =  var.ssh_user_name_for_groups
  ssh_key_name       =  var.ssh_key_name_for_groups
  web_script         =  var.web_script
  db_script          =  var.db_script
  net_name           =  module.network.network-name 
  subnet_for_web     =  module.network.subnetwork-name-public 
  subnet_for_db      =  module.network.subnetwork-name-private
  depends_on         = [module.network]
}


// create http balancer
module "http_balancer" {
  source             = "./modules/http_balancer"
  lb_proxy_port      = var.http_lb_proxy_port
  lb_protocol        = var.http_lb_protocol
  lb_hc_port         = var.http_lb_hc_port
  ins_group_name     = module.instance_group.web-group-instance
  depends_on         = [module.network, module.instance_group]
}


// create internal balancer
module "internal_balancer" {
  source             = "./modules/internal_balancer"
  lb_proxy_port      =  var.internal_lb_proxy_port 
  lb_hc_port         =  var.internal_lb_hc_port
  net_for_lb         =  module.network.network-name
  subnet_for_lb      =  module.network.subnetwork-name-private
  ins_group_name     =  module.instance_group.db-group-instance
  depends_on         = [module.network, module.instance_group]
}