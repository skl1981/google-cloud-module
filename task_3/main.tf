# export GOOGLE_CLOUD_KEYFILE_JSON=~/servicekey/terraform.json
provider "google" {
  project = var.project
  region  = var.region
}

locals {
  cidr_range = {
    public  = "10.${var.students_IDnum}.1.0/24"
    private = "10.${var.students_IDnum}.2.0/24"
  }
}

locals {
  fw_config = {
    external = {
      allow_ports   = ["80", "22"]
      source_ranges = ["0.0.0.0/0"]
    }
    internal = {
      allow_ports   = ["0-65535"]
      source_ranges = ["10.${var.students_IDnum}.0.0/16"]
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  count         = length(local.cidr_range)
  name          = "${element(keys(local.cidr_range), count.index)}-subnetwork"
  ip_cidr_range = lookup(local.cidr_range, element(keys(local.cidr_range), count.index))
  network       = google_compute_network.vpc_network.id
  description   = "${element(keys(local.cidr_range), count.index)}-network"
}

resource "google_compute_firewall" "fw_rule" {
  count   = length(local.fw_config)
  name    = "${var.student_name}-fw-rule-${count.index + 1}"
  network = google_compute_network.vpc_network.id

  dynamic "allow" {
    for_each = "${element(keys(local.fw_config), count.index)}" == "internal" ? ["tcp", "udp"] : ["tcp"]
    content {
      protocol = allow.value
      ports    = lookup(lookup(local.fw_config, element(keys(local.fw_config), count.index)), element(keys(local.fw_config.external), 0))
    }
  }
  /* Сам не понимаю как это все заработало, 2 уровня вложенности в мапе и эти значние не должны были выдергиваться, изза того что вызывается всегда external
Не баг, а фича (с)
*/
  source_ranges = lookup(lookup(local.fw_config, element(keys(local.fw_config), count.index)), element(keys(local.fw_config.external), 1))
}

resource "google_compute_instance" "instance" {
  name         = "${var.student_name}-server"
  zone         = var.zone
  machine_type = var.machine_type
  metadata_startup_script = templatefile("webserver.sh.tpl", {
    myname = "${var.student_name}"
  })
  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = "public-subnetwork"
    access_config { # Если нужно создать группу инстанов в публичной сети указываем этот блок для выдачи внешнего айпи
    }
  }
  depends_on = [google_compute_subnetwork.subnets]
}
