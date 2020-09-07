provider "google" {
  project = "vvv-test-100001"
  region  = "us-central1"
}

data "terraform_remote_state" "my_gcs_backend" {
  backend = "gcs"
  config = {
    bucket = "terraform-gvi"
    prefix = "tfstate"
  }
}

module "network" {
  source = "./modules/network"
}

module "instance" {
  source             = "./modules/instance"
  subnet_public_name = module.network.subnet_public_name
}

module "instance_group" {
  source              = "./modules/instance_group"
  subnet_public_name  = module.network.subnet_public_name
  subnet_private_name = module.network.subnet_private_name
}

module "internal_balancer" {
  source              = "./modules/internal_balancer"
  db_instance_group   = module.instance_group.db_instance_group
  subnet_private_name = module.network.subnet_private_name
  network_name        = module.network.network_name
}

module "http_load_balancer" {
  source             = "./modules/http_load_balancer"
  instance_group_web = module.instance_group.instance_group_web
}
