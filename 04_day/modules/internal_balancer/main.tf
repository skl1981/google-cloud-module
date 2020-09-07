/*provider "google" {
  project = var.project_id
  region  = var.region
}*/


// =================create internal load balancer======================


resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.name}-forwarding-rule"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.db-backend.id
  ports                 = var.lb_proxy_port
  network               = var.net_for_lb
  subnetwork            = var.subnet_for_lb
}

resource "google_compute_region_backend_service" "db-backend" {
  name                  = var.name
  backend {
    group               = data.google_compute_region_instance_group.dbserver.id
  }
  health_checks         = [google_compute_health_check.db-hc.id]
}

data "google_compute_region_instance_group" "dbserver" {
  name = var.ins_group_name // the name of the instance group that will be used as the backend
}


resource "google_compute_health_check" "db-hc" {
  name                   = "${var.name}-health-check"
  timeout_sec            = 3
  check_interval_sec     = 3
  tcp_health_check {
    port                 = var.lb_hc_port
  }
}