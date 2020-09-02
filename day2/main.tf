provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "my-first-lab-project1"
  region      = "us-central1"
}

resource "google_compute_instance" "default" {
        name = "nginx-${var.createway}"
        machine_type = "${var.machinetype}"
        zone = "${var.zone}"
        deletion_protection = var.delprot
        metadata_startup_script = file("install2.sh")

        tags = var.tags
        labels = var.labels
  lifecycle {
    ignore_changes = [attached_disk]
  }


boot_disk {
    initialize_params {
        image = "centos-7"
        size  = "35"
        type  = "pd-ssd"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
