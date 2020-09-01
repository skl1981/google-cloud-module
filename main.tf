
provider "google" {
  project = "vladimir-project-01"
  region  = "us-central1"
  credentials = "${file("vladimir-project-01-7b7039c36bc6.json")}" 
}

resource "google_compute_disk" "nginx-terraform" {
  name  = "test-terraform"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = google_compute_disk.nginx-terraform.id
  instance = google_compute_instance.default.id
}

variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "image" {}
variable "type" {}
variable "size" {
  type = number
}
variable "tags" {
  type = list
}
variable "labels" {
  type = map
}
variable "deletion_protection" {}
variable "network" {}

resource "google_compute_instance" "default" {
  name                = var.name
  machine_type        = var.machine_type
  zone                = var.zone
  deletion_protection = var.deletion_protection

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    network = var.network
    access_config {
      // Ephemeral IP
    }
  }

  tags                    = var.tags
   metadata_startup_script = <<SCRIPT
       sudo yum update
       sudo yum install -y nginx
       sudo systemctl enable nginx
       sudo systemctl start nginx
    SCRIPT
  labels                  = var.labels
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
