/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/

resource "google_compute_target_http_proxy" "http" {
  name    = var.proxy-name
  url_map = google_compute_url_map.urlmap_nginx.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = var.gfr-name
  target     = google_compute_target_http_proxy.http.self_link
  #ip_address = google_compute_global_address.http-lb-ga.address
  port_range = "80"

  #depends_on = [google_compute_global_address.http-lb-ga]
}

resource "google_compute_url_map" "urlmap_nginx" {
  name        = var.urlmap-name
  default_service = google_compute_backend_service.nginx.self_link
}

resource "google_compute_backend_service" "nginx" {
  name        = var.backend-service-name

  backend {
    group = var.instance-group
  }

  health_checks = [google_compute_health_check.http-lb-hc.self_link]

  depends_on = [var.dependences]
}

resource "google_compute_health_check" "http-lb-hc" {
  name    = var.health-check-name

  http_health_check {
    port         = 80
    #request_path = "/"
  }

  timeout_sec         = 3
  check_interval_sec  = 5
  healthy_threshold   = 4
  unhealthy_threshold = 5
}


