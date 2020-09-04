provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}

resource "google_compute_network" "vpc-ratomski" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description = "Custom network. ${var.student_name}"
}

resource "google_compute_firewall" "external" {
  name    = "external"
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = var.external-ports
  }

  source_ranges = ["0.0.0.0/0"]
  description = "External firewall rule for 22, 80 ports."
}

resource "google_compute_firewall" "internal" {
  name    = "internal"
  network = google_compute_network.vpc-ratomski.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.${var.student_IDnum}.0.0/16"]
  description = "Internal firewall rule for all ports(TCP, UDP)."
}

resource "google_compute_subnetwork" "sub-public" {
  name          = "sub-public"
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc-ratomski.id
  description = "Public subnetwork."
}

resource "google_compute_subnetwork" "sub-private" {
  name          = "sub-private"
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc-ratomski.id
  description = "Private subnetwork."
}

resource "google_compute_instance" "vratomski" {
  name         = "instance-${var.student_name}"
  machine_type = "n1-standard-1"
  zone         = var.zone
  description = "centOS + nginx with custom index.html"

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = google_compute_subnetwork.sub-public.id
    access_config {
    }
  }

  metadata_startup_script = templatefile("start_nginx.sh", {student_name = var.student_name})
}