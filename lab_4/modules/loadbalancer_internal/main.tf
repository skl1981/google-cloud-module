data "google_compute_region_instance_group" "db_server" {
  name                  = var.instancegroup_name
}
data "google_compute_network" "default" {
  name                  = var.network
}
data "google_compute_subnetwork" "default" {
  name                  = var.subnet
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.prefix}-forwarding-rule"
  load_balancing_scheme = var.balancing_scheme
  backend_service       = google_compute_region_backend_service.backend.id
  ports                 = var.balancing_ports
  network               = data.google_compute_network.default.id
  subnetwork            = data.google_compute_subnetwork.default.id
}

resource "google_compute_region_backend_service" "backend" {
  name                  = "${var.prefix}-region-backend-loadbalancer"
  backend {
    group               = data.google_compute_region_instance_group.db_server.id
  }
  health_checks         = [google_compute_health_check.db_server_healthcheck.id]
}

resource "google_compute_health_check" "db_server_healthcheck" {
  name                  = "${var.prefix}-internal-db-server-healthcheck"
  http_health_check {
    port                = var.db_server_healthcheck_port
  }
}
