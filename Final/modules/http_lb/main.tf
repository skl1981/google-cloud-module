# used to forward traffic to the correct load balancer for HTTP load balancing 
resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = var.gfr_name
  target     = google_compute_target_http_proxy.target_http_proxy.id
  port_range = var.gfr_port
}

# used by one or more global forwarding rule to route incoming HTTP requests to a URL map
resource "google_compute_target_http_proxy" "target_http_proxy" {
  name    = var.proxy_name
  url_map = google_compute_url_map.url_map.id
}

# used to route requests to a backend service based on rules that you define for the host and path of an incoming URL
resource "google_compute_url_map" "url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.backend_service.id
}

# defines a group of virtual machines that will serve traffic for load balancing
resource "google_compute_backend_service" "backend_service" {
  name                    = var.backend_name
  port_name               = var.backend_port_name
  protocol                = var.backend_protocol
  health_checks           = ["${google_compute_health_check.http-healthcheck.id}"]

  backend {
    group                 = var.backend_group
    balancing_mode = var.backend_balancing_mode
    capacity_scaler       = var.backend_capacity
    max_rate_per_instance = var.backend_rpi
  }
}

# determine whether instances are responsive and able to do work
resource "google_compute_health_check" "http-healthcheck" {
  name               = var.http_healthcheck_name
  timeout_sec        = var.hc_timeout
  check_interval_sec = var.hc_interval
  http_health_check {
    port = var.hc_port
  }
}
