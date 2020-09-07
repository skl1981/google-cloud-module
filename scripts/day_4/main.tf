terraform {
  backend "gcs" {
    bucket      = "izaitsava-bucket"
    prefix      = "terraform/"
  }
}

provider "google" {
  credentials       = "/home/mumz/.servicekey/terraform-admin.json"
  project           = var.project
  region            = var.region
}

module "network" {
  source            = "./modules/network"
}

module "managed_instance_groups" {
  source            = "./modules/managed_instance_groups"
  ssh_user          = var.ssh_user
  ssh_key           = var.ssh_key
  student_name      = var.student_name
  student_surname   = var.student_surname
  zones             = var.zones
  depends_on        = [module.network]
}

module "nginx_loadbalancer" {
  source            = "./modules/nginx_loadbalancer"
  depends_on        = [module.managed_instance_groups,module.network]
}

module "db_loadbalancer" {
  source            = "./modules/db_loadbalancer"
  depends_on        =  [module.managed_instance_groups,module.network]
}

module "instances" {
  source            = "./modules/instances"
  depends_on        = [module.network]  
}
