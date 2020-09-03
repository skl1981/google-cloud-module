provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "${var.projectname}"
  region      = "${var.region}"
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.network-name}"
  auto_create_subnetworks = false
  description             = "create VPC"
}

resource "google_compute_subnetwork" "public-sub-net" {
  name          = "${var.public-sub-net}"
  ip_cidr_range = "${var.publicip}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
  depends_on    = [google_compute_network.vpc_network, ]
  description   = "create public subnetwork"
}

resource "google_compute_subnetwork" "privat-sub-net" {
  name          = "${var.privat-sub-net}"
  ip_cidr_range = "${var.privatip}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
  depends_on    = [google_compute_network.vpc_network, ]
  description   = "create privat subnetwork"
}

resource "google_compute_firewall" "vpc-firewall-ext" {
  name    = "firewall-ext-rules"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "create firewall external rules"
}

resource "google_compute_firewall" "vpc-firewall-int" {
  name    = "firewall-int-rules"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = ["${var.privatip}"] #!!!!!check
  description   = "create firewall internal rules"
}
resource "google_compute_instance" "default" {
  name         = "nginx-${var.createway}"
  machine_type = "${var.machinetype}"
  zone         = "${var.zone}"
  #  deletion_protection = var.delprot
  metadata_startup_script = file("starup.sh")
  description             = "create vm"

  #    tags = var.tags
  #    labels = var.labels

  depends_on = [google_compute_network.vpc_network, ]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "25"
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public-sub-net.id
    access_config {
      // Ephemeral IP
    }
  }
}
