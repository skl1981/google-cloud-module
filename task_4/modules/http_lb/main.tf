# ==============Datasource from existing instance-group==========
data "google_compute_region_instance_group" "default" {
  name = var.ig_name
}
data "google_compute_network" "default" {
  name = var.network
}

# ============Create http lb health check =======================
resource "google_compute_health_check" "http" {
  count               = var.http_health_check ? 1 : 0
  name                = "${var.name}-http-lb-hc"
  timeout_sec         = var.hc_timeout_sec
  check_interval_sec  = var.hc_check_interval_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold
  http_health_check {
    port = var.lb_health_check_port
  }
}
resource "google_compute_health_check" "tcp" {
  count               = var.http_health_check ? 0 : 1
  name                = "${var.name}-http-lb-hc"
  timeout_sec         = var.hc_timeout_sec
  check_interval_sec  = var.hc_check_interval_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold
  tcp_health_check {
    port = var.lb_health_check_port
  }
}

# Firewall for health check
resource "google_compute_firewall" "default" {
  count   = var.firewall_rule_hc ? 1 : 0
  name    = "${var.name}-fw-http-lb-hc"
  network = data.google_compute_network.default.name
  allow {
    protocol = "tcp"
    ports    = [var.lb_health_check_port]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

#==================Create backend service for lb=================
resource "google_compute_backend_service" "default" {
  name          = "${var.name}-backend-service"
  health_checks = ["${element(compact(concat(google_compute_health_check.tcp.*.id, google_compute_health_check.http.*.id)), 0)}"]
  backend {
    group = data.google_compute_region_instance_group.default.id
  }
}
#=================Create HTTP lb ================================
resource "google_compute_url_map" "lb" {
  name            = "${var.name}-urlmap"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.lb.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "${var.name}-fw-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}