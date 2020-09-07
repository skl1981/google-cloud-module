//  network and sub
resource "google_compute_network" "vpc_network" {
  name                    = var.net_name
  auto_create_subnetworks = false
  description             = "custom-vpc-network"
}

resource "google_compute_subnetwork" "public" {
  name          = var.sub_pub_name
  ip_cidr_range = var.sub_pub_range
  network       = google_compute_network.vpc_network.id
  description   = "public-subnetwork in vpc network"
}

resource "google_compute_subnetwork" "private" {
  name          = var.sub_priv_name
  ip_cidr_range = var.sub_priv_range
  network       = google_compute_network.vpc_network.id
  description   = "private-subnetwork in vpc network"
  private_ip_google_access = true
}

//bastion host
resource "google_compute_firewall" "ssh-jump" {
  name          = "ssh-jump"
  network       = google_compute_network.vpc_network.name
  allow {
    protocol    = "tcp"
    ports       = var.jump_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-jump"]
}

//web group instance
resource "google_compute_firewall" "db-rule" {
  name          = "db-rule"
  network       = google_compute_network.vpc_network.name
  allow {
    protocol    = "tcp"
    ports       = var.db_ports
  }
  target_tags   = ["db"]
}

//db group instance
resource "google_compute_firewall" "web-rule" {
  name    = "web-rule"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = var.web_ports
  }
  target_tags = ["web"]
}

// NAT
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.public.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}