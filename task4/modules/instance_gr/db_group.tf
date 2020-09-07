
// template web group

resource "google_compute_instance_template" "dbserver" {
  name        = "dbserver-template"
  description = "This template is used to create web server instances."
  tags = ["db"]
  instance_description = "description assigned to instances"
  machine_type         = var.machine_type
  scheduling {
    automatic_restart  = true
  }
  disk {
    source_image = "${var.image_project}/${var.image_family}"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network       = var.net_name
    subnetwork    = var.subnet_for_db
  }
  metadata_startup_script = file("db.sh")
  metadata = {
    ssh-keys = "ubuntu:${file("key.pub")}"
  }
}

// db instance group

resource "google_compute_region_instance_group_manager" "dbserver" {
  name                       = "db-igm"
  base_instance_name         = var.base_inst_name_db
  region                     = var.region
  target_size                = var.count_ins_db
  version {
    instance_template = google_compute_instance_template.dbserver.id
  }
  auto_healing_policies {
    health_check             = google_compute_health_check.db-health-check.id
    initial_delay_sec        = 3000
  }
}

// health-check db group

resource "google_compute_health_check" "db-health-check" {
  name = "tcp-health-check"
  timeout_sec        = 1
  check_interval_sec = 1
  tcp_health_check {
    port             = "5432"
  }
}


