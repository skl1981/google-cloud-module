#####################################################################
# Creating internal backend service + health_check

resource "google_compute_region_backend_service" "db" {
  region = "us-central1"
  name   = "db-region-service"


  backend {
    group = var.db_instance_group
  }

  health_checks = [google_compute_health_check.db.id]
}


resource "google_compute_health_check" "db" {
  name               = "db-health-check"
  description        = "Health check via tcp"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "5432"
  }
}


######################################################################
# Forwarding rule for Internal Load Balancing

resource "google_compute_forwarding_rule" "db_int_lb" {
  name                  = "db-int-lb-rule"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.db.id
  ports                 = ["5432"]
  network               = var.network_name
  subnetwork            = var.subnet_private_name
}
