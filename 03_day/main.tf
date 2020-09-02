provider "google" {
  credentials = "terraform-admin.json"
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "custom-vpc-network"
}

resource "google_compute_firewall" "external" {
  name    = "${var.student_name}-firewall-external"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "firewall rule for http and ssh for external conections"
}

resource "google_compute_firewall" "internal" {
  name    = "${var.student_name}-firewall-internal"
  network = google_compute_network.vpc_network.name
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.${var.student_IDnum}.0.0/16"]
  description   = "firewall rule for internal conections in our vpc-network"
}


resource "google_compute_subnetwork" "public" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "public-subnetwork in ${var.student_name}-vpc network"
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "private-subnetwork in ${var.student_name}-vpc network"
  private_ip_google_access = true
}

resource "google_compute_instance" "vm_instance" {
  name         = var.name_instance
  machine_type = var.machine_type
  zone         = var.zone
  description  = "nginx-web-server-instance"

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }
  metadata_startup_script = templatefile("script.sh.tpl", { name = "${var.student_name}" })
  
  network_interface {
    subnetwork =   google_compute_subnetwork.public.id
    access_config {
    }
  }
}