data "google_compute_region_instance_group" "private" {
  name                  = var.instance_group_name_private  
}

#----------------------------------------------------------#
# Create compute forwarding rules for postgress instances  #
#----------------------------------------------------------#

resource "google_compute_forwarding_rule" "postgress" {
  name                  = "db-forwarding-rule"
  region                = var.region
  project               = var.project
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.db-backend.id
  ports                 = var.ports
  network               = var.network
  subnetwork            = var.private_subnet
}

#-------------------------------------------------------------#
# Create compute backend-service for postgress loadbalancer   #
#-------------------------------------------------------------#

resource "google_compute_region_backend_service" "db-backend" {
  name                  = "db-backend-service"
  region                = var.region
  #locality_lb_policy   = "ROUND_ROBIN"
  session_affinity      = "NONE"
  backend {
    group               = data.google_compute_region_instance_group.private.self_link
  }
  health_checks         = [google_compute_health_check.private-autohealing.id]
}

#---------------------------------------------------------------#
# Create compute autohealing policy for postgress instances     #
#---------------------------------------------------------------#

resource "google_compute_health_check" "private-autohealing" {
  name                   = "private-autohealing"
  check_interval_sec     = "4"
  timeout_sec            = "4"
  tcp_health_check {
    port                 = "5432"
  }
}
