#---------------------------------------------------#
# Module for Cloud NAT                              #
#---------------------------------------------------#

module "cloud_nat" {
  source  = "./modules/cloud-nat"
  network_name = module.vpc_network.network_name
  subnetwork_name_public  =  module.vpc_subnetwork_public.subnetwork_name
  subnetwork_name_private  =  module.vpc_subnetwork_private.subnetwork_name
  region = var.region
}

#---------------------------------------------------#
# Modules for network                               #
#---------------------------------------------------#

module "vpc_network"{
  source  = "./modules/network"
  student_name = var.student_name 
}

module "vpc_subnetwork_public" {
  source  = "./modules/subnetwork"
  network_name = module.vpc_network.network_name 
  subnetwork_name  =  var.subnetwork_name_public
  subnetwork_range  =  var.subnetwork_range_public
  region = var.region
}

module "vpc_subnetwork_private" {
  source  = "./modules/subnetwork"
  network_name = module.vpc_network.network_name
  subnetwork_name  =  var.subnetwork_name_private
  subnetwork_range  =  var.subnetwork_range_private
  region = var.region
}

#---------------------------------------------------#
# Modules for instance and managed groups           #
#---------------------------------------------------#

module "bastion" {
    source = "./modules/instance"
    name = var.name_bastion_instance
    region = var.region
    image = var.image
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type =  var.disk_type
    name_prefix = var.name_prefix
    metadata = var.metadata
    zone = var.bastion_zone
    tags = var.bastion_tags
    target_tags = var.bastion_tags
    source_tags = var.bastion_tags
    network_name = module.vpc_network.network_name
    subnetwork_name = module.vpc_subnetwork_public.subnetwork_name
}

module "web" {
    source = "./modules/managed_instance_group"
    region = var.region
    image = var.image
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type =  var.disk_type
    name_prefix = var.name_prefix
    metadata = var.metadata
    distribution_policy_zones = var.distribution_policy_zones
    tags = var.web_tags
    script = var.web_script
    group_name =  var.web_group_name
    target_size = var.web_target_size
    named_ports = var.web_named_ports
    base_instance_name = var.web_base_instance_name
    autoscaler = var.autoscaler
    subnetwork_name = module.vpc_subnetwork_public.subnetwork_name
}

module "db" {
    source = "./modules/managed_instance_group"
    region = var.region
    image = var.image
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type =  var.disk_type
    name_prefix = var.name_prefix
    metadata = var.metadata
    distribution_policy_zones = var.distribution_policy_zones
    tags = var.db_tags
    script = var.db_script
    group_name =  var.db_group_name
    target_size = var.db_target_size
    named_ports = var.db_named_ports
    base_instance_name = var.db_base_instance_name
    subnetwork_name = module.vpc_subnetwork_private.subnetwork_name
}

#---------------------------------------------------#
# Modules for http- and internal- load-balancers    #
#---------------------------------------------------#

module "http-lb" {
   source = "./modules/http-lb"
   app_name = var.app_name
   group_name = module.web.managed_group_instance_group
   source_ranges = [module.http-lb.load-balancer-ip-address]
   target_tags = var.web_tags
   network_name = module.vpc_network.network_name
}

module "internal-lb" {
   source = "./modules/internal-lb"
   name = var.db_name
   group_name = module.db.managed_group_instance_group
   health_check_port = var.health_check_port
   protocol = var.protocol
   ports = var.ports
   ip_address = var.ip_address
   source_tags = var.web_tags
   target_tags = var.db_tags
   destination_ranges = [module.internal-lb.internal-balancer-ip-address]
   network =  module.vpc_network.network_name
}

