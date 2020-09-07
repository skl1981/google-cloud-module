
// =================create template for db group======================

resource "google_compute_instance_template" "dbserver" {
  name                 = "${var.db_name}-template"
  tags                 = var.db_ins_tags
  machine_type         = var.machine_type_db
  disk {
    source_image       = var.image_db
  }
  network_interface {
    network            = var.net_name
    subnetwork         = var.subnet_for_db
  }
  metadata_startup_script = file(var.db_script)
  metadata             = {
    ssh-keys           = "${var.ssh_user_name}:${file(var.ssh_key_name)}"
  }
}


// =================create health-check for db group=================

resource "google_compute_health_check" "db-health-check" {
  name                 = "${var.db_name}-health-check"
  timeout_sec          = 1
  check_interval_sec   = 1
  tcp_health_check {
    port               = var.db_hc_port
  }
}


// =================create db instance group=====================

resource "google_compute_region_instance_group_manager" "dbserver" {
  name                 = "${var.db_name}-igm"
  base_instance_name   = var.base_inst_name_db
  region               = var.region
  target_size          = var.count_ins_db
  version {
    instance_template  = google_compute_instance_template.dbserver.id
  }
  auto_healing_policies {
    health_check       = google_compute_health_check.db-health-check.id
    initial_delay_sec  = 300
  }
}