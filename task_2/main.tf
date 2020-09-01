# export GOOGLE_CLOUD_KEYFILE_JSON=~/servicekey/terraform.json
provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_disk" "pd-nginx" {
  count = var.creation-way == "gcp-terraform" ? 1 : 0
  name  = "disk-${var.creation-way}"
  zone  = var.zone
  size  = var.pd_size
}

resource "google_compute_attached_disk" "default" {
  count    = var.creation-way == "gcp-terraform" ? 1 : 0
  disk     = google_compute_disk.pd-nginx[0].id
  instance = google_compute_instance.nginx.id
}

resource "google_compute_instance" "nginx" {
  name         = "nginx-${var.creation-way}"
  zone         = var.zone
  machine_type = var.machine_type
  tags         = var.network_tags
  metadata_startup_script = templatefile("webserver.sh.tpl", {
    condition = "${var.creation-way}"
  })
  #  metadata_startup_script = length(google_compute_disk.pd-nginx) == 1 ? file("disk-setup.sh") : file("webserver.sh")
  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = var.disk_size_gb
    }
  }
  network_interface {
    network = var.network
    access_config {
    }
  }
  labels = merge(var.labels, { way_of_installation = "${var.creation-way}" })
  lifecycle {
    prevent_destroy = true
    #    ignore_changes = []
  }
}




# Лишнее - трафик можно фильтровать по предустановленным таргет-тегам http(s)-server
/*
resource "google_compute_firewall" "fw_rule_http" {
  name    = "fw-rule-${var.creation-way}"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = var.allow_ports
  }
  target_tags = var.network_tags
}
*/
