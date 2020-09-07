resource "google_compute_firewall" "vpc_firewall_ex1" {
  name    = "ssh-to-bastion"
  network =  var.network_name
  description = "allow access through ssh to bastion"

  allow {
  protocol = "tcp"
  ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = var.target_tags
}

resource "google_compute_firewall" "vpc_firewall_int1" {
  name    = "ssh-from-bastion"
  network =  var.network_name
  description = "allow ssh access in internal network"
  allow {
  ports = ["22"]
  protocol = "tcp"
  }
  source_tags=var.source_tags
}

resource "google_compute_instance_template" "instance_template" {
  name_prefix = "${var.name_prefix}-"
  machine_type = var.machine_type
  metadata = var.metadata
  region = var.region
  tags = var.tags
  metadata_startup_script = var.script
  disk {
     source_image = var.image
     disk_size_gb = var.disk_size_gb
     disk_type = var.disk_type
  }
  network_interface{
    subnetwork = var.subnetwork_name
  }
}

resource "google_compute_instance_from_template" "compute_instance_public" {	
  name = var.name
  zone = var.zone
  tags = var.tags
  metadata = var.metadata
  metadata_startup_script = var.script
  network_interface {
     subnetwork = var.subnetwork_name
     access_config {	
     }
  }
  source_instance_template = google_compute_instance_template.instance_template.id
}

