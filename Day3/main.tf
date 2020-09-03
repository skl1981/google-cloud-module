provider "google" {
  project = "vvv-test-100001"
  region  = "us-central1"
}

#################################################################
#  Creating VPC network


resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  description             = "${var.student_name}-vpc-network"
  auto_create_subnetworks = false
}

#################################################################
#  Creating firewalls rules

resource "google_compute_firewall" "external_access" {
  name    = "${var.student_name}-ext-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

resource "google_compute_firewall" "internal_access" {
  name    = "${var.student_name}-int-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.${var.student_id}.2.0/24"]
}

#################################################################
# Creating auto_create_subnetworks

resource "google_compute_subnetwork" "public" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.${var.student_id}.1.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-public subnetwork"
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.${var.student_id}.2.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-private subnetwork"
}

##################################################################
# Creating Vm instance

resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone


  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    network    = "${var.student_name}-vpc"
    subnetwork = google_compute_subnetwork.private.id
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<SCRIPT
       sudo yum update
       sudo yum install -y nginx
       sudo systemctl enable nginx
       sudo systemctl start nginx
       echo "<h1>Hello from ${var.student_name}</h1>" > /usr/share/nginx/html/index.html
    SCRIPT
}
