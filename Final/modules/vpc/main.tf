#create vpc
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.ac_sub
  routing_mode            = var.route_mod
}
#create public and private subnets
resource "google_compute_subnetwork" "public_subnet" {
  name          = var.sub_name_1
  ip_cidr_range = var.cidr_1
  network       = google_compute_network.vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = var.sub_name_2
  ip_cidr_range = var.cidr_2
  network       = google_compute_network.vpc.name
  region        = var.region
}
#reserve static ip for jump-host
resource "google_compute_address" "nat_ip" {
  
  name = var.nat_ip_name
  region = var.region
}


