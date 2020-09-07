resource "google_compute_firewall" "vpc_firewall_ex2" {
  name    = "http-lb-health-check"
  network =  var.network_name
  description = "allow access to health check"

  allow {
  protocol = "tcp"
  ports = ["80"]
  }
  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = var.target_tags
}

resource "google_compute_firewall" "vpc_firewall_int2" {
  name    = "http-lb-access-to-web"
  network =  var.network_name
  description = "allow access to web"

  allow {
  protocol = "tcp"
  ports = ["80"]
  }
  source_ranges = var.source_ranges
  target_tags = var.target_tags
  
}

resource "google_compute_health_check" "healthcheck" {
  name = "${var.app_name}-healthcheck"
  timeout_sec = 1
  check_interval_sec = 10
  http_health_check {
  port = 80
  }
}

resource "google_compute_backend_service" "backend_service" {
  name = "${var.app_name}-backend-service"
  port_name = "http"
  protocol = "HTTP"
  health_checks =[google_compute_health_check.healthcheck.self_link]
  backend {
    group =var.group_name
    balancing_mode = "RATE"
    max_rate_per_instance = 100
  }
}

resource "google_compute_url_map" "url_map" {
  name = "${var.app_name}-load-balancer"
  default_service =google_compute_backend_service.backend_service.self_link
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  name = "${var.app_name}-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name = "${var.app_name}-global-forwarding-rule"
  target =google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "80"
}

