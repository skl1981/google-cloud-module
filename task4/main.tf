// Please export variables 
// export GOOGLE_CLOUD_KEYFILE_JSON=vladimir-project-01-7b7039c36bc6.json
// export GOOGLE_BACKEND_CREDENTIALS=vladimir-project-01-7b7039c36bc6.json

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = "${file("vladimir-project-01-7b7039c36bc6.json")}"
}

module "instance_gr" {
  source             = "./modules/instance_gr"
  project_id         = var.project_id
  region             = var.region
  zone               = var.zone
  machine_type       = var.machine_type
  image_project      = var.image_project
  image_family       = var.image_family
  net_name           = module.network.network-name
  subnet_for_web     = module.network.subnetwork-name-public
  subnet_for_db      = module.network.subnetwork-name-private
  base_inst_name_web = var.base_inst_name_web
  count_ins_web      = var.count_ins_web
  student_name       = var.student_name
  student_surname    = var.student_surname
  base_inst_name_db  = var.base_inst_name_db
  count_ins_db       = var.count_ins_db
  depends_on         = [module.network]
}

module "internal_balancer" {
  source        = "./modules/int_balancer"
  project_id    = var.project_id
  region        = var.region
  ports_int_lb  = var.ports_int_lb
  net_int_lb    = module.network.network-name
  subnet_int_lb = module.network.subnetwork-name-private
  depends_on    = [module.network, module.instance_gr]
}

module "http_balancer" {
  source     = "./modules/http_balancer"
  project_id = var.project_id
  region     = var.region
  depends_on = [module.network, module.instance_gr]
}

module "instance" {
  source        = "./modules/instance"
  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  name_instance = var.name_instance
  machine_type  = var.machine_type
  image_project = var.image_project
  image_family  = var.image_family
  disk_type     = var.disk_type
  disk_size_gb  = var.disk_size_gb
  net_name      = module.network.network-name
  sub_pub_name  = module.network.subnetwork-name-public
  depends_on    = [module.network]
}

module "network" {
  source         = "./modules/networks"
  project_id     = var.project_id
  region         = var.region
  zone           = var.zone
  net_name       = var.net_name
  sub_priv_name  = var.sub_priv_name
  sub_pub_name   = var.sub_pub_name
  sub_priv_range = var.sub_priv_range
  sub_pub_range  = var.sub_pub_range
  jump_ports     = var.jump_ports
  web_ports      = var.web_ports
  db_ports       = var.db_ports
}