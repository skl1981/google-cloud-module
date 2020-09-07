resource "google_compute_health_check" "tcp" {
  name = "${var.name}-hc"
  tcp_health_check {
     port = var.health_check_port
  }
}

resource "google_compute_region_backend_service" "default" {
  name = var.name
  protocol = var.protocol
  timeout_sec = 10
  backend {
    group =var.group_name
  }
  health_checks = [google_compute_health_check.tcp.self_link]
}

resource "google_compute_forwarding_rule" "internal-lb" {	
  name = var.name
  subnetwork = var.subnetwork
  load_balancing_scheme = "INTERNAL"
  backend_service = google_compute_region_backend_service.default.self_link
  ip_address = var.ip_address
  ip_protocol = var.protocol
  ports = var.ports
}

resource "google_compute_firewall" "load_balancer" {
  name = "internal-lb-acces-to-db"
  network = var.network
  allow {
    protocol = lower(var.protocol)
    ports = var.ports
  }
  source_tags = var.source_tags
}

resource "google_compute_firewall" "health_check" {
  name = "internal-lb-health-check"
  network = var.network
  allow {
    protocol = "tcp"
    ports = [var.health_check_port]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags =  var.target_tags
}

