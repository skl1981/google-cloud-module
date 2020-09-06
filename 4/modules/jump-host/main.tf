/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/

resource "google_compute_instance" "vratomski" {
  name         = "jump-host-${var.student-name}"
  machine_type = var.machine-type
  zone         = var.zone

  tags = var.tag-p22

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = var.sub-public-name
    access_config {

    }
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-keys}"
  }

  depends_on = [var.dependences]
}