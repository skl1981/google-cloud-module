/*provider "google" {
  project = var.project_id
  region  = var.region
}*/


// =================create internal load balancer======================

data "google_compute_region_instance_group" "dbserver" {
  name = "db-igm"
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "website-forwarding-rule"
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.db-backend.id
  ports                 = var.ports_int_lb
  network               = var.net_int_lb
  subnetwork            = var.subnet_int_lb
}

resource "google_compute_region_backend_service" "db-backend" {
  name                  = "db-backend"
  region                = var.region
  backend {
    group               = data.google_compute_region_instance_group.dbserver.self_link
  }
  health_checks         = [google_compute_health_check.db-hc.id]
}

resource "google_compute_health_check" "db-hc" {
  name               = "check-db-backend"
  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port             = "5432"
  }
}