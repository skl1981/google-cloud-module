provider "google" {
  credentials = file("../../terraform-admin.json")
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "nginx-terraform" {
  name         = var.name
  machine_type = var.machine_type
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = var.network
    access_config {
    }
  }

  labels = var.labels

  tags = var.tags

  deletion_protection = var.deletion_protection

  metadata_startup_script = <<SCRIPT
      sudo yum update
      sudo yum install nginx -y
      sudo systemctl start nginx
    SCRIPT
}

