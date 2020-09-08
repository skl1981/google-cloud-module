provider "google" {
  project = var.project_id 
  region = var.region     
  zone = var.zone     
  credentials = "weighty-forest-288021-a66f9faea241.json"
}

////////////
///bucket///
////////////

terraform {
  backend "gcs" {
    bucket = "mshnipau-bucket"
    prefix = "terraform/"
  }
}

///////////////////////////////////
///create network with cloud nat///
///////////////////////////////////

module "network" {
  source = "./modules/network"
  project_id = var.project_id              
  region = var.region  
  zone = var.zone    
  net_name = var.net_name 
  private_sub_name = var.private_sub_name 
  public_sub_name = var.public_sub_name   
  private_sub_range = var.private_sub_range 
  public_sub_range = var.public_sub_range 
  jump_ports = var.jump_ports  
  web_ports = var.web_ports  
  db_ports = var.db_ports 
}

////////////////////
///create bastion///
////////////////////

module "instance" {
  source = "./modules/instance"
  project_id =  var.project_id 
  region = var.region 
  zone = var.zone 
  name_instance = var.name_instance 
  machine_type = var.machine_type 
  image_project = var.image_project 
  image_family = var.image_family 
  disk_type = var.disk_type 
  disk_size_gb = var.disk_size_gb 
  net_name = module.network.network-name
  public_sub_name = module.network.subnetwork-name-public
  depends_on = [module.network]
}

//////////////////////////////////////////
///create templates and instance groups///
//////////////////////////////////////////

module "instance_group" {
  source = "./modules/instance_group"
  project_id = var.project_id 
  region = var.region 
  zone = var.zone 
  machine_type = var.machine_type 
  image_project = var.image_project 
  image_family = var.image_family 
  net_name = module.network.network-name 
  subnet_for_web = module.network.subnetwork-name-public 
  base_inst_name_web = var.base_inst_name_web 
  count_ins_web = var.count_ins_web 
  student_name = var.student_name
  student_surname = var.student_surname
  subnet_for_db = module.network.subnetwork-name-private
  base_inst_name_db = var.base_inst_name_db 
  count_ins_db = var.count_ins_db  
  depends_on = [module.network]
}

///////////////////////////////
///create http_load_balancer///
///////////////////////////////

module "http_load_balancer" {
  source = "./modules/http_load_balancer"
  project_id = var.project_id 
  region = var.region 
  depends_on = [module.network, module.instance_group]
}

///////////////////////////////////
///create internal_load_balancer///
///////////////////////////////////

module "internal_balancer" {
  source = "./modules/internal_balancer"
  project_id = var.project_id 
  region = var.region 
  ports_int_lb = var.ports_int_lb 
  net_int_lb = module.network.network-name
  subnet_int_lb = module.network.subnetwork-name-private
  depends_on = [module.network, module.instance_group]
}