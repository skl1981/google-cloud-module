# create VPC
resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "custom-vpc-network"
}

# create public subnet
resource "google_compute_subnetwork" "public" {
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet
  network       = google_compute_network.vpc_network.id
  description   = "public-subnet in ${var.student_name}-vpc"
  region        = var.region
}

# create private subnet
resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet
  network       = google_compute_network.vpc_network.id
  description   = "private-subnet in ${var.student_name}-vpc"
  private_ip_google_access = true
  region        = var.region
}

# create firewall rules
resource "google_compute_firewall" "external-http-port" {
  name    = "${var.student_name}-firewall-http-lb"
  network = google_compute_network.vpc_network.id
  allow {
    ports    = var.external_http_ports
	protocol = "tcp"
  }
  target_tags   = var.web_tags
  description   = "rule for http port"
}

resource "google_compute_firewall" "external-ssh-port" {
  name    = "${var.student_name}-firewall-ssh"
  network = google_compute_network.vpc_network.id
  allow {
    ports    = var.ssh_external_ports
	protocol = "tcp"
  }
  target_tags   = var.external_ssh_tags
  description   = "rule for ssh port"
}

resource "google_compute_firewall" "internal-db-ports" {
  name    = "${var.student_name}-firewall-internal-dbs"
  network = google_compute_network.vpc_network.id
  allow {
    ports    = var.internal_db_ports
	protocol = "tcp"
  }
  allow {
    protocol = "icmp"
  }
  target_tags   = var.db_tags
  description   = "rule for internal conections for dbs"
}


# create a nat to allow private instances connect to internet
resource "google_compute_router" "nat-router" {
  name    = "${var.student_name}-nat-router"
  region  = google_compute_subnetwork.private.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "${var.student_name}-nat-gateway"
  region                             = google_compute_router.nat-router.region
  router                             = google_compute_router.nat-router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
