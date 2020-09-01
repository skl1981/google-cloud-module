provider "google" {
  credentials = file("/home/mee/gcp/terraform-admin.json")  
  project     = var.project_id 
  region      = var.region     
  zone        = var.zone       
}

resource "google_compute_instance" "nginx" {
  name                = var.instance_name
  machine_type        = var.machine_type
  tags                = var.network_tags

  labels              = var.custom_labels
  deletion_protection = var.protection

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = var.disk_size_custom
      type  = var.disk_type
    }
  }
   
  metadata_startup_script = file("run.sh")  
  
  network_interface {
    network = var.network_type
    access_config {
    }
  }
}
resource "google_compute_disk" "nginx-disk" {
  name  = var.disk_name
  type  = var.disk_type
  size  = var.disk_size_default
  zone  = var.zone
}

resource "google_compute_attached_disk" "nginx-attached" {
  disk     = google_compute_disk.nginx-disk.id
  instance = google_compute_instance.nginx.id
}

output "URL" {
  value = "http://${google_compute_instance.nginx.network_interface.0.access_config.0.nat_ip}"
}

variable "project_id" {
  type  = string
}
variable "region" {
  type  = string
}
variable "zone" {
  type  = string
}
variable "image_project" {
  type  = string
}
variable "image_family" {
  type  = string
}
variable "instance_name" {
  type  = string
}
variable "machine_type" {
  type  = string
}
variable "network_type" {
  type  = string
}
variable "network_tags" {
  type  = list
}
variable "disk_name" {
  type  = string
}
variable "disk_type" {
  type  = string
}
variable "disk_size_custom" {
  type  = string
}
variable "disk_size_default" {
  type  = string
}
variable "custom_labels" {
  type  = map
}
variable "protection" {
  type  = bool
}
