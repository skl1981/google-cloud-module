provider "google" {
  credentials = "terraform-admin.json"
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "nginx-gcp-terraform" {
  name                = var.name
  zone                = var.zone
  machine_type        = var.type
  deletion_protection = var.delete
  tags                = var.tags
  labels              = var.labels
   
  boot_disk {
    initialize_params {
    size  = var.disk_size
    type  = var.disk_type
    image = var.disk_image
    }
  }

  network_interface {
    network    = var.network_type
    subnetwork = var.network_type
    access_config {
	}
  }


  metadata_startup_script = "${file("simplenginx.sh")}"
}

resource "google_compute_disk" "nginx-disk" {
  name = var.persistent_disk_name
  size = var.persistent_disk_size 
  type = var.persistent_disk_type 
  zone = var.zone
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.nginx-disk.id
  instance = google_compute_instance.nginx-gcp-terraform.id
}

output "URL" {
  value = "http://${google_compute_instance.nginx-gcp-terraform.network_interface.0.access_config.0.nat_ip}"
}