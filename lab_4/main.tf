# export GOOGLE_CLOUD_KEYFILE_JSON=~/gcp/terraform-admin.json
provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "kkarpau-lab-4"
    prefix = "terraform-lab-4/"
    # export GOOGLE_BACKEND_CREDENTIALS=~/gcp/terraform-admin.json
  }
}

module "vpc_net" {
  source  = "./modules/vpc_net"
  ssh_key = "${var.ssh_username}:${file(var.ssh_key)}"
      
  project            =  var.project
  region             =  var.region  
  zone               =  var.zone   
  machine_type       =  var.machine_type 
  image_project      =  var.image_project 
  image_family       =  var.image_family 
  vpc_net            =  var.vpc_net_name
  prefix             =  var.vpc_net_prefix

  subnet_public_name           = var.subnet_public_name
  subnet_private_name          = var.subnet_private_name
  subnet_public_ip_cidr_range  = var.subnet_public_cidr
  subnet_private_ip_cidr_range = var.subnet_private_cidr
  net_jumphost_allow_ports     = var.net_jumphost_ports  
  net_external_allow_ports     = var.net_external_allow_ports
  net_internal_allow_ports_t   = var.net_internal_allow_ports_t
}

module "instance_group" {
  source             = "./modules/instance_group"
  network            =  module.vpc_net.vpc_net_name
  web_subnetwork     =  module.vpc_net.public_subnet_name
  db_subnetwork      =  module.vpc_net.private_subnet_name

  region             =  var.region 
  machine_type       =  var.machine_type 
  image_project      =  var.image_project 
  image_family       =  var.image_family  
  student_name       =  var.student_name
  student_surname    =  var.student_surname

  prefix_web         =  var.prefix_web 
  web_instance_count =  var.web_instance_count
  prefix_db          =  var.prefix_db 
  db_instance_count  =  var.db_instance_count 

  depends_on         = [module.vpc_net]
  ssh_key            = "${var.ssh_username}:${file(var.ssh_key)}"

}

module "loadbalancer_web" {
  source            = "./modules/loadbalancer_web"
  depends_on        = [module.vpc_net, module.instance_group]
}

module "loadbalancer_internal" {
  source            = "./modules/loadbalancer_internal"
  balancing_ports   =  var.balancing_ports
  network           =  module.vpc_net.vpc_net_name
  subnet            =  module.vpc_net.private_subnet_name  
  depends_on        = [module.vpc_net, module.instance_group]
}
