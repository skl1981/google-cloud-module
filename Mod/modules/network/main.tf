#################################################################
#  Creating VPC network


resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  description             = "${var.student_name}-vpc-network"
  auto_create_subnetworks = false
}


#################################################################
# Creating subnetworks

resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = "10.${var.student_id}.1.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-public subnetwork"
  region        = "us-central1"
}

resource "google_compute_subnetwork" "private" {
  name          = "private"
  ip_cidr_range = "10.${var.student_id}.2.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-private subnetwork"
  region        = "us-central1"
}


#####################################################################
# Configuring router + NAT for availability installation pkg

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.public.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.public.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


#################################################################
#  Creating firewalls rules

resource "google_compute_firewall" "external_access_jump" {
  name    = "${var.student_name}-ext-firewall-jump"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "icmp"
  }

  #source_tags = ["jump"]
  target_tags = ["jump"]

}

resource "google_compute_firewall" "external_access_web" {
  name    = "${var.student_name}-ext-firewall-web"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  target_tags = ["web"]
}


resource "google_compute_firewall" "internal_access" {
  name    = "${var.student_name}-int-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "5432"]
  }

  allow {
    protocol = "udp"
    ports    = ["22", "5432"]
  }

  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.${var.student_id}.1.0/24"]
}

resource "google_compute_firewall" "internal_access1" {
  name    = "${var.student_name}-int-firewall-1"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "5432"]
  }

  allow {
    protocol = "udp"
    ports    = ["22", "5432"]
  }

  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.${var.student_id}.2.0/24"]
}

resource "google_compute_firewall" "health1" {
  name    = "${var.student_name}-health1"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80", "5432"]
  }

  allow {
    protocol = "udp"
    ports    = ["80", "5432"]
  }

  allow {
    protocol = "icmp"
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}
