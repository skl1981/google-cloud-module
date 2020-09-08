////////////////
///create VPC///
////////////////

resource "google_compute_network" "vpc_network" {
  name = var.net_name
  auto_create_subnetworks = false
  description = "custom-vpc-network"
}

//////////////////////////
///create public_subnet///
//////////////////////////

resource "google_compute_subnetwork" "public" {
  name = var.public_sub_name
  ip_cidr_range = var.public_sub_range
  network = google_compute_network.vpc_network.id
  description = "public-subnetwork in vpc network"
}

///////////////////////////
///create private_subnet///
///////////////////////////

resource "google_compute_subnetwork" "private" {
  name = var.private_sub_name
  ip_cidr_range = var.private_sub_range
  network = google_compute_network.vpc_network.id
  description = "private-subnetwork in vpc network"
  private_ip_google_access = true
}

///////////////////////////
///create firewall rules///
///////////////////////////

resource "google_compute_firewall" "ssh-jump" {
  name = "ssh-jump"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports = var.jump_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh-jump"]
}

resource "google_compute_firewall" "db-rule" {
  name = "db-rule"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports = var.db_ports
  }
  target_tags = ["db"]
}

resource "google_compute_firewall" "web-rule" {
  name = "web-rule"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports = var.web_ports
  }
  target_tags = ["web"]
}

/////////////////////////////////////////////////////////////////////
///create a NAT to allow private instances connect to the Internet///
/////////////////////////////////////////////////////////////////////

resource "google_compute_router" "router" {
  name = "my-router"
  region = google_compute_subnetwork.public.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name = "my-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}