data "google_compute_region_instance_group" "db_internal_group" {
  name                  = "${var.student_name}-db-group"
}

resource "google_compute_forwarding_rule" "internal_forwarding_rule" {
  name                  = "${var.student_name}-internal-forwarding-rule"
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.internal_db_backend.id
  ports                 = var.tcp_lb_ports
  network               = var.network_custom_vpc
  subnetwork            = var.subnetwork_custom_private
}

resource "google_compute_region_backend_service" "internal_db_backend" {
  name                  = "${var.student_name}-internal-db-backend"
  region                = var.region
  backend {
    group               = data.google_compute_region_instance_group.db_internal_group.self_link
  }
  health_checks         = [google_compute_health_check.db-healthcheck.id]
}

resource "google_compute_health_check" "db-healthcheck" {
  name               = "${var.student_name}-internal-db-healthcheck"
  check_interval_sec = 10
  timeout_sec        = 5
  tcp_health_check {
    port             = var.db_port
  }
}

# firewall for health check
resource "google_compute_firewall" "internal-hc" {
  name    = "${var.student_name}-internal-db-hc"
  network = var.network_custom_vpc
  allow {
    protocol = "tcp"
    ports    = var.tcp_lb_ports
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}