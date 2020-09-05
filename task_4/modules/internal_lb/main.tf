data "google_compute_region_instance_group" "default" {
  name = var.ig_name
}
data "google_compute_network" "default" {
  name = var.network
}
data "google_compute_subnetwork" "default" {
  name = var.subnet
}

# ===================Create internal lb with custom balanced ports===========

resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.name}-fw-rule"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.id
  ports                 = var.balanced_ports
  network               = data.google_compute_network.default.id
  subnetwork            = data.google_compute_subnetwork.default.id
}

resource "google_compute_region_backend_service" "backend" {
  name = "${var.name}-internal-lb"
  backend {
    group = data.google_compute_region_instance_group.default.id
  }
  health_checks = ["${element(compact(concat(google_compute_health_check.tcp.*.id, google_compute_health_check.http.*.id)), 0)}"]
}

# Choose health check
resource "google_compute_health_check" "tcp" {
  count = var.http_health_check ? 0 : 1
  name  = "${var.name}-internal-lb-hc"
  tcp_health_check {
    port = var.lb_health_check_port
  }
}
resource "google_compute_health_check" "http" {
  count = var.http_health_check ? 1 : 0
  name  = "${var.name}-internal-lb-hc"
  http_health_check {
    port = var.lb_health_check_port
  }
}

# Firewall for health check
resource "google_compute_firewall" "default" {
  count   = var.firewall_rule_hc ? 1 : 0
  name    = "${var.name}-fw-int-lb-hc"
  network = data.google_compute_network.default.name
  allow {
    protocol = "tcp"
    ports    = [var.lb_health_check_port]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}