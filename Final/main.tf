provider "google" {
  project = var.app_project
  region  = var.gcp_region_1
}
module "network" {
  source = "./modules/vpc"
  vpc_name = "${var.app_name}-vpc"
  sub_name_1 = "${var.app_name}-public-subnet"
  cidr_1 = var.private_subnet_cidr_1
  sub_name_2 = "${var.app_name}-private-subnet"
  cidr_2 = var.private_subnet_cidr_2
}

module "firewall" {
  source = "./modules/firewall_rules"
  network = "${module.network.vpc_name}"
}

module "instance" {
  source = "./modules/instance"
  zone = var.gcp_zone_1
  meta_ssh_key = {
    ssh-keys = "${var.gcp_user}:${var.gcp_key}"
  }
  network = "${module.network.vpc_name}"
  subnet = "${module.network.subnet_public}"
  nat_name = "${var.app_name}-nat-router"
  nat_ip = "${module.network.nat_ip}" #Do not delete or modify
  network_id = "${module.network.network_id}" #Do not delete or modify
}

module "templates" {
  source = "./modules/templates"
  region = var.gcp_region_1
    meta_ssh_key = {
    ssh-keys = "${var.gcp_user}:${var.gcp_key}"
  }
  network = "${module.network.vpc_name}"
  nginx_subnet = "${module.network.subnet_public}"
  postgres_subnet = "${module.network.subnet_private}"
}

module "instance_groups" {
  source = "./modules/instance-groups"
  nginx_igm_template = "${module.templates.nginx_template_id}" #Do not delete or modify
  postgres_igm_template = "${module.templates.postgres_template_id}" #Do not delete or modify
}

module "http_lb" {
  source = "./modules/http_lb"
  gfr_name = "${var.app_name}-global-forwarding-rule"
  proxy_name = "${var.app_name}-proxy"
  url_map_name = "${var.app_name}-load-balancer"
  backend_name = "${var.app_name}-backend-service"
  backend_group = "${module.instance_groups.http_instance_group}"
  http_healthcheck_name = "${var.app_name}-http-healthcheck"
}

module "postgres_lb" {
  source = "./modules/postgres_lb"
  fr_name = "${var.app_name}-postgres-forwarding-rule"
  network = "${module.network.vpc_name}"
  subnet = "${module.network.subnet_private}"
  backend_name = "${var.app_name}-postgres-backend-service"
  backend_group = "${module.instance_groups.postgres_instance_group}"
  hc_name = "${var.app_name}-postgres-healthcheck"
}



