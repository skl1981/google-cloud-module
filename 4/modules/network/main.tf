/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/


#---------------------
#     NETWORK
#---------------------
resource "google_compute_network" "vpc-ratomski" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = false
}

#---------------------
#     FIREWALL
#---------------------
resource "google_compute_firewall" "external80" {
  name    = var.fw-ext-p80-name
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.port-80
  }

  target_tags = var.tag-ext-80
  source_ranges = var.all-source-ranges 
}

resource "google_compute_firewall" "external22" {
  name    = var.fw-ext-p22-name 
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.port-22
  }

  target_tags = var.tag-ext-22
  source_ranges = var.all-source-ranges
}

resource "google_compute_firewall" "internal" {
  name    = var.fw-int-name
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.internal-ports
  }

  allow {
    protocol = "udp"
    ports    = var.internal-ports
  }

  source_ranges = ["10.${var.student_IDnum}.0.0/16"]
}

#---------------------
#     SUBNETWORKS
#---------------------
resource "google_compute_subnetwork" "sub-public" {
  name          = var.sub-public-name
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc-ratomski.id
}

resource "google_compute_subnetwork" "sub-private" {
  name          = var.sub-private-name
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc-ratomski.id
}

#--------------------------------
#     FW RULES FOR HEALTHCHECK
#--------------------------------
resource "google_compute_firewall" "allow80" {
  name    = var.fw-ext-lb-name
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.port-80
  }

  source_ranges = var.hc-source-ranges
}

resource "google_compute_firewall" "allow5432" {
  name    = var.fw-int-lb-name
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.port-5432
  }
  allow {
    protocol = "udp"
    ports    = var.port-5432
  }

  source_ranges = var.hc-source-ranges
}