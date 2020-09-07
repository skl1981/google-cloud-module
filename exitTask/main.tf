terraform {
  backend "gcs" {
	credentials = "terraform-admin.json"
    bucket = "dkramich-task4"
    prefix = "terraform_bucket/"
  }
}

# create network with cloud nat
module "network" {
  source              = "./modules/network"
  project             = var.project            
  region              = var.region  
  student_name        = var.student_name 
  external_ranges     = var.external_ranges
  external_http_ports = var.external_http_ports
  ssh_external_ports  = var.ssh_external_ports 
  internal_db_ports   = var.internal_db_ports
  internal_ranges     = var.internal_ranges
  public_subnet       = var.public_subnet
  private_subnet      = var.private_subnet
  web_tags            = var.web_tags
  external_ssh_tags   = var.external_ssh_tags
  db_tags             = var.db_tags
}

# create bastion server
module "instance" {
  source                   = "./modules/instance"
  project                  = var.project
  region                   = var.region
  zone                     = var.zone
  machine_type             = var.machine_type
  disk_size                = var.disk_size
  student_name             = var.student_name
  network_custom_vpc       = var.network_custom_vpc
  subnetwork_custom_public = var.subnetwork_custom_public
  disk_type                = var.disk_type
  images                   = var.images
  ssh_key                  = "${var.ssh_user}:${file(var.ssh_key)}"
  depends_on               = [module.network]
}
 
# create templates and instance groups
module "instance_group" {
  source                    = "./modules/instance_group"
  project                   = var.project
  region                    = var.region
  zone                      = var.zone
  student_name              = var.student_name
  machine_type              = var.machine_type
  disk_size                 = var.disk_size
  network_custom_vpc        = var.network_custom_vpc
  subnetwork_custom_public  = var.subnetwork_custom_public
  subnetwork_custom_private = var.subnetwork_custom_private
  disk_type                 = var.disk_type
  images                    = var.images
  ssh_key                   = "${var.ssh_user}:${file(var.ssh_key)}"
  distribution_zones        = var.distribution_zones
  web_replicas              = var.web_replicas
  db_replicas               = var.db_replicas  
  depends_on                = [module.network]
}
 
# create http-lb and conect him to group
module "http_lb" {
  source       = "./modules/http_lb"
  project      = var.project
  region       = var.region
  student_name = var.student_name
  http_port    = var.http_port
  depends_on   = [module.network, module.instance_group]
}

# create internal-lb
module "internal_balancer" {
  source                    = "./modules/internal_balancer"
  project                   = var.project
  region                    = var.region
  student_name              = var.student_name
  db_port                   = var.db_port
  tcp_lb_ports              = var.tcp_lb_ports
  network_custom_vpc        = var.network_custom_vpc
  subnetwork_custom_private = var.subnetwork_custom_private
  depends_on                = [module.network, module.instance_group]
}