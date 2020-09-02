provider "google" {
  credentials = "terraform-admin.json"
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = var.name_instance
  machine_type = var.machine_type

  tags                = var.tags
  labels              = var.labels
  deletion_protection = var.delete 

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }
   
  metadata_startup_script = file("script.sh")
  
  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
resource "google_compute_disk" "default" {
  name  = "new-disk"
  type  = "pd-ssd"
  size  = "20"
  zone  = "us-central1-c"
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.vm_instance.id
}

