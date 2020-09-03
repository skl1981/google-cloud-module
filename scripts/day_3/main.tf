provider "google" {
  credentials = "/home/mumz/.servicekey/izaits-admin.json"
  project = "${var.student_name}-vpc"
  region  = var.region
}


resource "google_compute_instance" "instance" {
  name = var.instance
  zone = var.zone
  machine_type = var.machine_type
  description = "custom instance"

  boot_disk {
    initialize_params {
    type = var.boot_disk_type
    size = var.boot_disk_size
    image = "${var.image_project}/${var.image_family}"
    }
  }
  metadata_startup_script = templatefile("./startup.sh", { student_name = "${var.student_name}" })  
  network_interface {
    subnetwork =   google_compute_subnetwork.public_subnet.id
    access_config {}
  }
}


resource "google_compute_network" "network" {
  name = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description = "vpc-network"
}


resource "google_compute_firewall" "external" {
  name = "external-fwd"
  network = google_compute_network.network.name
  description = "firewall rules for external connect"
  allow {
    protocol = "tcp"
    ports= ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "internal" {
  name    = "internal-fwd"
  network = google_compute_network.network.name
  description = "firewall rules for internal connect"
 
 allow {
    ports = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.${var.student_IDnum}.0.0/16"]
}



resource "google_compute_subnetwork" "public_subnet" {
  name = "public-subnetwork"
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  network = google_compute_network.network.id
  description = "public-subnet"
}


resource "google_compute_subnetwork" "private_subnet" {
  name = "private-subnetwork"
  private_ip_google_access = true
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  network = google_compute_network.network.id
  description = "private-subnet"
}
