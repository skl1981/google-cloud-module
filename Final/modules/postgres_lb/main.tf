#lb for postgres 
resource "google_compute_forwarding_rule" "postgres-forwarding-rule" {
  name   = var.fr_name
  load_balancing_scheme = var.fr_scheme
  backend_service = google_compute_region_backend_service.postgres-backend.self_link
  ports  = var.fr_ports
  network = var.network
  subnetwork = var.subnet
}

resource "google_compute_region_backend_service" "postgres-backend" {
  name             = var.backend_name
  protocol         = var.backend_protocol
  timeout_sec      = var.backend_to
  session_affinity = var.backend_sa
  backend {
    group = var.backend_group
  }
  health_checks = ["${google_compute_health_check.postgres-healthcheck.self_link}"]
}
resource "google_compute_health_check" "postgres-healthcheck" {
  name               = var.hc_name
  check_interval_sec = var.hc_interval
  timeout_sec        = var.hc_timeout
  tcp_health_check {
    port = var.hc_port
  }
}