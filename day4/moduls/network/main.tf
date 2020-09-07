#>>>>>>     create network   <<<<<<
resource "google_compute_network" "vpc_network" {
  name                    = "${var.network-name}"
  auto_create_subnetworks = false
  description             = "create VPC"
}
#>>>>>>     create subnetworks    <<<<<<<<<
resource "google_compute_subnetwork" "public_sub_net" {
  name          = "${var.public-sub-net}"
  ip_cidr_range = "${var.publicip}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
  depends_on    = [google_compute_network.vpc_network, ]
  description   = "create public subnetwork"
}

resource "google_compute_subnetwork" "privat_sub_net" {
  name          = "${var.privat-sub-net}"
  ip_cidr_range = "${var.privatip}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
  depends_on    = [google_compute_network.vpc_network, ]
  description   = "create privat subnetwork"
}

#>>>>>>     create firewall <<<<<<<<

resource "google_compute_firewall" "vpc_firewall-ext" {
  name        = "firewall-ext-rules"
  network     = google_compute_network.vpc_network.name
  source_tags = ["internet"]
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = "${var.ext-port}"
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "create firewall external rules for 80,22 ports"
}

resource "google_compute_firewall" "vpc_firewall-int" {
  name        = "firewall-int-rules"
  network     = google_compute_network.vpc_network.name
  source_tags = ["tointernal"]
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = "${var.all-port}"
  }
  allow {
    protocol = "udp"
    ports    = "${var.all-port}"
  }
  source_ranges = "${var.internal-ip}"
  description   = "create firewall internal rules"
}

resource "google_compute_firewall" "vpc_firewall-jump" {
  name        = "firewall-jump-rules"
  network     = google_compute_network.vpc_network.name
  source_tags = ["jumphost"]
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "create firewall external rules for jumpHost 22 ports"
}

resource "google_compute_firewall" "firewall_health_check" {
  count   = 0
  name    = "firewall-health-check"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = "${var.all-port}"
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  description   = "create firewall rules for health_check"
}

#>>>>>>>>   create gcp nat    <<<<<<
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.public_sub_net.region
  network = google_compute_network.vpc_network.id
}
resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.public_sub_net.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  subnetwork {
    name                    = google_compute_subnetwork.privat_sub_net.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
