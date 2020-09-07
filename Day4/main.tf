provider "google" {
  credentials                             = file("terraform-admin.json")
  project                                 = "devopslab2020-288208"
  region                                  = "us-central1"
}

module "vpc_create" {
  source                                  = "./modules/vpc"
  mod_vpc_name                            = var.vpc_name
  mod_vpc_auto_create_subnetworks         = var.vpc_auto_create_subnetworks
}

module "subnetwoks_create" {
  source                                  = "./modules/subnetwork"
  mod_subnetwork_names                    = var.subnetwork_names  
  mod_subnetwork_ip_ranges                = var.subnetwork_ip_ranges
  mod_subnetwork_vpc_name                 = var.vpc_name
  depends_on                              = [module.vpc_create]
}

module "firewall_rules_create" {
  source                                  = "./modules/firewall_rule"
  mod_firewall_network_name               = var.vpc_name
  mod_firewall_protocol_tcp               = var.firewall_protocol_tcp              
  mod_firewall_protocol_udp               = var.firewall_protocol_udp              
  mod_firewall_protocol_sctp              = var.firewall_protocol_sctp             
  mod_firewall_ports_ssh                  = var.firewall_ports_ssh                 
  mod_firewall_ports_http                 = var.firewall_ports_http                
  mod_firewall_ports_db                   = var.firewall_ports_db                  
  mod_firewall_tag_jump_host              = var.jump_host_tags     
  mod_firewall_tag_web_server             = var.firewall_tag_web_server            
  mod_firewall_tag_database_server        = var.firewall_tag_database_server       
  mod_ingress_ssh_allow_jump_host_name    = var.ingress_ssh_allow_jump_host_name   
  mod_ingress_ssh_jump_host_source_ranges = var.ingress_ssh_jump_host_source_ranges
  mod_ingress_ssh_deny_from_vms_name      = var.ingress_ssh_deny_from_vms_name         
  mod_ingress_ssh_name                    = var.ingress_ssh_name                   
  mod_ingress_http_name                   = var.ingress_http_name                  
  mod_ingress_db_name                     = var.ingress_db_name
  depends_on                              = [module.vpc_create, module.subnetwoks_create]
}

module "cloud_NAT_create" {
  source                                  = "./modules/nat"
  mod_router_name                         = var.router_name
  mod_router_vpc_name                     = var.vpc_name
  mod_nat_name                            = var.nat_name
  mod_nat_ip_option                       = var.nat_ip_option
  mod_nat_subnetwork_ip_ranges            = var.nat_subnetwork_ip_ranges
  depends_on                              = [module.vpc_create, module.subnetwoks_create]
}

module "jump_host_create" {
  source                                  = "./modules/jump_host"
  mod_jump_host_name                      = var.jump_host_name 
  mod_jump_host_type                      = var.jump_host_type 
  mod_jump_host_zone                      = var.jump_host_zone  
  mod_jump_host_image                     = var.jump_host_image
  mod_jump_host_tags                      = var.jump_host_tags   
  mod_jump_host_subnetwork                = var.jump_host_subnetwork
  mod_jump_host_network_interface         = var.vpc_name
  ssh_key                                 = "${var.ssh_user}:${file(var.ssh_key)}"
  depends_on                              = [module.vpc_create, module.subnetwoks_create]
}

module "web_server_create" {
  source                                  = "./modules/web-server"
  mod_studentName                         = var.studentName          
  mod_studentSurname                      = var.studentSurname       
  mod_nginx_template_prefix               = var.nginx_template_prefix
  mod_nginx_template_tags                 = var.nginx_template_tags
  mod_nginx_template_type                 = var.jump_host_type
  mod_nginx_template_image                = var.jump_host_image
  mod_nginx_template_network_interface    = var.vpc_name
  mod_nginx_template_subnetwork           = var.jump_host_subnetwork
  mod_nginx_mig_name                      = var.nginx_mig_name       
  mod_nginx_mig_base_name                 = var.nginx_mig_name
  mod_nginx_mig_region                    = var.region
  mod_nginx_mig_zone_a                    = var.nginx_mig_zone_a    
  mod_nginx_mig_zone_b                    = var.nginx_mig_zone_b
  mod_nginx_mig_zone_c                    = var.nginx_mig_zone_c
  mod_nginx_mig_target_size               = var.nginx_mig_target_size
  mod_nginx_scaler_name                   = var.nginx_scaler_name    
  mod_nginx_scaler_min_rep                = var.nginx_scaler_min_rep 
  mod_nginx_scaler_max_rep                = var.nginx_scaler_max_rep 
  mod_nginx_scaler_cool_per               = var.nginx_scaler_cool_per
  mod_nginx_scaler_target                 = var.nginx_scaler_target  
  ssh_key                                 = "${var.ssh_user}:${file(var.ssh_key)}"
  depends_on                              = [module.vpc_create, module.subnetwoks_create, module.cloud_NAT_create]
}

module "database_server_create" {
  source                                  = "./modules/database-server"
  mod_db_template_prefix                  = var.db_template_prefix
  mod_db_template_tags                    = var.db_template_tags
  mod_db_template_type                    = var.jump_host_type
  mod_db_template_image                   = var.jump_host_image
  mod_db_template_network_interface       = var.vpc_name
  mod_db_template_subnetwork              = var.db_host_subnetwork
  mod_db_mig_name                         = var.db_mig_name       
  mod_db_mig_base_name                    = var.db_mig_name
  mod_db_mig_region                       = var.region
  mod_db_mig_zone_a                       = var.nginx_mig_zone_a    
  mod_db_mig_zone_b                       = var.nginx_mig_zone_b
  mod_db_mig_zone_c                       = var.nginx_mig_zone_c
  mod_db_mig_target_size                  = var.db_mig_target_size
  ssh_key                                 = "${var.ssh_user}:${file(var.ssh_key)}"
  depends_on                              = [module.vpc_create, module.subnetwoks_create, module.cloud_NAT_create]  
}

module "http_lb_create" {
  source                                  = "./modules/http-lb"
  mod_http_lb_hc_name                     = var.http_lb_hc_name
  mod_http_lb_bk_name                     = var.http_lb_bk_name
  mod_backend_group                       = "${module.web_server_create.instance_group_nginx}"
  mod_http_lb_map_name                    = var.http_lb_map_name            
  mod_http_lb_proxy_name                  = var.http_lb_proxy_name          
  mod_http_lb_forw_rule_name              = var.http_lb_forw_rule_name      
  mod_http_lb_forw_rule_port_range        = var.http_lb_forw_rule_port_range 
  depends_on                              = [module.vpc_create, module.subnetwoks_create, module.cloud_NAT_create] 
}

module "internal_lb_create" {
  source                                  = "./modules/internal-lb"
  mod_int_lb_hc_name                      = var.int_lb_hc_name                  
  mod_int_lb_hc_port                      = var.int_lb_hc_port                  
  mod_int_lb_bk_name                      = var.int_lb_bk_name                  
  mod_int_backend_group                   = "${module.database_server_create.instance_group_db}"             
  mod_int_lb_forw_rule_name               = var.int_lb_forw_rule_name                 
  mod_int_lb_forw_rule_scheme             = var.int_lb_forw_rule_scheme                 
  mod_int_lb_forw_rule_ports              = var.int_lb_forw_rule_ports                  
  mod_int_lb_forw_rule_network_name       = var.vpc_name                 
  mod_int_lb_forw_rule_subnetwork_name    = var.db_host_subnetwork     
  depends_on                              = [module.vpc_create, module.subnetwoks_create, module.cloud_NAT_create]            
}