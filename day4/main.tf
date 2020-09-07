provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.projectname}"
  region      = "${var.region}"
}


#terraform {
#  backend "gcs" {
#    bucket = "bucket_exit_task"
#    prefix = "terraform/exit-task"
#  }
#}


module "network" {
  source         = "./moduls/network"
  network-name   = "${var.new-name-net}"
  publicip       = "${var.publicip}"
  public-sub-net = "${var.public-sub-net}"
  privatip       = "${var.privatip}"
  privat-sub-net = "${var.privat-sub-net}"
  ext-port       = "${var.ext-port}"
  all-port       = "${var.all-port}"
}


module "instance" {
  source               = "./moduls/instance"
  network-name         = module.network.network-name
  sub-network-ext-name = module.network.sub-network-ext-name
  machinetype          = "${var.machinetype}"
  image                = "${var.image}"
  hdd-size             = "${var.hdd-size}"
  hdd-type             = "${var.hdd-type}"
}


module "mig" {
  source               = "./moduls/mig"
  network-name         = module.network.network-name
  sub-network-ext-name = module.network.sub-network-ext-name
  sub-network-int-name = module.network.sub-network-int-name
  site-image           = "${var.site-image}"
  policy-zone          = "${var.policy-zone}"
  site-target-size     = "${var.site-target-size}"
  db-target-size       = "${var.db-target-size}"
}


module "httplb" {
  source    = "./moduls/httplb"
  http-mig  = module.mig.http-mig
  http-port = "${var.http-port}"
}


module "internallb" {
  source                = "./moduls/internallb"
  internal-mig          = module.mig.internal-mig
  network-name          = module.network.network-name
  sub-network-int-name  = module.network.sub-network-int-name
  forwarding-rule-ports = "${var.forwarding-rule-ports}"
  tcp-port              = "${var.tcp-port}"

}
