resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  description = "Custom network"
}

resource "google_compute_firewall" "vpc_firewall_ex" {
  name    = "external-rule"
  network = google_compute_network.vpc_network.name
 description = "allow access through ssh and http"

 allow {
 protocol = "tcp"
 ports = ["80", "22"]
 }
 source_ranges = ["0.0.0.0/0"]
 }

resource "google_compute_firewall" "vpc_firewall_int" {
  name    = "internal-rule"
  network = google_compute_network.vpc_network.name
  description = "allow access in internal network"
 allow {
 ports = ["0-65535"]
 protocol = "tcp"
 }
 allow {
 ports = ["0-65535"]
 protocol = "udp"
 }
 source_ranges = [var.network_range]
 }

resource "google_compute_subnetwork" "vpc_subnetwork_public" {
  name          = "public-subnetwork"
  ip_cidr_range = var.public_subnetwork
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  description  = "public subnetwork of custom network"
}

resource "google_compute_subnetwork" "vpc_subnetwork_private" {
  name          = "private-subnetwork"
  ip_cidr_range = var.private_subnetwork
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  description  = "private subnetwork of custom network"
}

resource "google_compute_instance" "vm_instance" {
name    =var.name
machine_type =var.machine_type
zone     = var.zone

boot_disk {
  initialize_params {
      image =var.image
      size  =var.size
      type  =var.disk_type
    }
  }

network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork_public.id

    access_config {
    }
  }

metadata_startup_script = templatefile("./startup.sh", {student_name = var.student_name})
}

