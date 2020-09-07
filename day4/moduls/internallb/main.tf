resource "google_compute_health_check" "db_health_check" {
  name               = "db-health-check"
  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port = "${var.tcp-port}" #?????????????
  }
}

resource "google_compute_region_backend_service" "db_backend" {
  name          = "db-backend"
  region        = "${var.region}"
  health_checks = [google_compute_health_check.db_health_check.id]

  backend {
    group = "${var.internal-mig}" #google_compute_region_instance_group_manager.dbserver.instance_group
  }
}

resource "google_compute_forwarding_rule" "db" {
  name                  = "website-forwarding-rule"
  backend_service       = google_compute_region_backend_service.db_backend.id
  region                = "${var.region}"
  load_balancing_scheme = "INTERNAL"
  ports                 = "${var.forwarding-rule-ports}"
  #allow_global_access   = true
  network    = "${var.network-name}"
  subnetwork = "${var.sub-network-int-name}"
}
