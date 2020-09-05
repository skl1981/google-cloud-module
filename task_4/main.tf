# export GOOGLE_CLOUD_KEYFILE_JSON=~/servicekey/terraform.json
provider "google" {
  project = var.project
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "imelnik1-exit_task"
    prefix = "terraform/"
    # export GOOGLE_BACKEND_CREDENTIALS=~/servicekey/terraform.json
  }
}

# Create infrastructure
module "network" {
  source  = "./modules/network"
  ssh_key = "${var.ssh_username}:${file(var.ssh_key)}"
}

# Create Cloud NAT for access to Internet from private subnets
module "nat" {
  source     = "./modules/cloud_nat"
  network    = module.network.network_name
  depends_on = [module.network]
}

# Create MIG with custom instance count and preinstalled apps
module "mig_web" {
  source            = "./modules/mig"
  ssh_key           = "${var.ssh_username}:${file(var.ssh_key)}"
  startup_script    = var.web_instance_startup_script
  http_health_check = var.http_health_check
  depends_on        = [module.nat]
}

# Create MIG with custom instance count and preinstalled apps
module "mig_db" {
  source               = "./modules/mig"
  name                 = var.ig_db_name
  subnetwork           = module.network.private_subnet_name
  instance_count       = var.db_instance_count
  ssh_key              = "${var.ssh_username}:${file(var.ssh_key)}"
  startup_script       = var.db_instance_startup_script
  distribution_zones   = var.db_distribution_zones
  ig_health_check_port = var.db_health_check_port
  depends_on           = [module.nat]
}

# Create HTTP lb
module "http_lb" {
  source            = "./modules/http_lb"
  ig_name           = module.mig_web.ig_name
  http_health_check = var.http_health_check
  depends_on        = [module.mig_web]
}

# Create internal lb
module "internal_lb" {
  source     = "./modules/internal_lb"
  ig_name    = module.mig_db.ig_name
  depends_on = [module.mig_db]
}