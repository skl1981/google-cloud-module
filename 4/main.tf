module "network" {
  source = "./modules/network"
  region = var.region
  student_name = var.student_name
  student_IDnum = var.student_IDnum
  #firewall 
  fw-ext-p80-name = var.fw-ext-p80-name
  fw-ext-p22-name = var.fw-ext-p22-name
  fw-int-name = var.fw-int-name
  port-80 = var.port-80
  port-22 = var.port-22
  internal-ports = var.internal-ports
  tag-ext-80 = var.tag-ext-80
  tag-ext-22 = var.tag-ext-22
  all-source-ranges = var.all-source-ranges
  #sunets
  sub-public-name = var.sub-public-name
  sub-private-name = var.sub-private-name
  #fw rules for healthcheck
  fw-ext-lb-name = var.fw-ext-lb-name
  fw-int-lb-name = var.fw-int-lb-name
  port-5432 = var.port-5432
  hc-source-ranges = var.hc-source-ranges
}

module "jump-host" {
  source = "./modules/jump-host"
  student-name = var.student_name
  zone = var.zone
  image = var.image
  size = var.size
  type = var.type
  sub-public-name = var.sub-public-name
  machine-type = var.machine-type
  tag-p22 = var.tag-p22
  ssh-user = var.ssh-user
  ssh-keys = var.ssh-keys
  depends_on = [module.network]
}

module "instance-group" {
  source = "./modules/instance-group"
  my_name = var.my_name
  my_surname = var.my_surname
  image = var.image
  multi-zones = var.multi-zones
  region = var.region
  machine-type = var.machine-type
  nginx-instance-prefix = var.nginx-instance-prefix
  group-manager-nginx-name = var.group-manager-nginx-name
  sub-public-name = var.sub-public-name
  sub-private-name = var.sub-private-name
  postgres-instance-prefix = var.postgres-instance-prefix
  group-manager-postgres-name = var.group-manager-postgres-name
  base-instance-name-n = var.base-instance-name-n
  base-instance-name-p = var.base-instance-name-p
  nginx-autoscaler-name = var.nginx-autoscaler-name
  ext-tags = var.ext-tags
  ssh-user = var.ssh-user
  ssh-keys = var.ssh-keys
  depends_on = [module.network]
}

module "http-load-balancer" {
  source = "./modules/HTTP-load-balancer"
  proxy-name = var.proxy-name
  backend-service-name = var.backend-service-name
  urlmap-name = var.urlmap-name
  gfr-name = var.gfr-name
  health-check-name = var.health-check-name
  instance-group = module.instance-group.instance-group
  depends_on = [module.instance-group]
}

module "internal-balancer" {
  source = "./modules/internal-balancer"
  fr-name = var.fr-name
  region-backend-service-name = var.region-backend-service-name
  int-health-check-name = var.int-health-check-name
  student_name = var.student_name
  sub-private-name = var.sub-private-name
  instance-group = module.instance-group.instance-group-postgres
}

module "cloud-nat" {
  source = "./modules/cloud-nat"
  cloud-router-name = var.cloud-router-name
  cloud-nat-name = var.cloud-nat-name
  student_name = var.student_name
  depends_on = [module.network.network]
}





