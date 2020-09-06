/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/

resource "google_compute_forwarding_rule" "int" {
  name       = var.fr-name
  load_balancing_scheme = "INTERNAL"
  ports = ["5432"]
  network = "${var.student_name}-vpc"
  subnetwork = var.sub-private-name
  backend_service = google_compute_region_backend_service.postgres.id
}

resource "google_compute_region_backend_service" "postgres" {
  name        = var.region-backend-service-name

  backend {
    group = var.instance-group #selflink
  }

  health_checks = [google_compute_health_check.int-lb-hc.self_link]
}

resource "google_compute_health_check" "int-lb-hc" {
  name    = var.int-health-check-name

  tcp_health_check {
    port         = 5432
    #request_path = "/"
  }

  timeout_sec         = 3
  check_interval_sec  = 5
  healthy_threshold   = 4
  unhealthy_threshold = 5
}

