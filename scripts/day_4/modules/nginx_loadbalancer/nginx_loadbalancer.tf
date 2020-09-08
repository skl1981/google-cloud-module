data "google_compute_region_instance_group" "public" {
  name                      = var.instance_group_name_public 
}

#-------------------------------------------------------------#
# Create compute global forwarding rules for nginx instances  #
#-------------------------------------------------------------#

resource "google_compute_global_forwarding_rule" "nginx" {
  name                      = var.forwarding_rule
  target                    = google_compute_target_http_proxy.nginx.id
  port_range                = var.port_range
}

#--------------------------------------------------------------------------------#
# Create global forwarding rule to route incoming HTTP requests to a URL map     #
#--------------------------------------------------------------------------------#

resource "google_compute_target_http_proxy" "nginx" {
  name                      = var.target_proxy
  url_map                   = google_compute_url_map.nginx.id
}

#-------------------------------------------------------------#
# Create compute url map of nginx instances                   #
#-------------------------------------------------------------#

resource "google_compute_url_map" "nginx" {
  name                      = var.proxy_url_map
  default_service           = google_compute_backend_service.nginx-backend.id
}

#-------------------------------------------------------------#
# Create compute backend-service for nginx loadbalancer       #
#-------------------------------------------------------------#

resource "google_compute_backend_service" "nginx-backend" {
  name                      = var.name_backend
  project                   = var.project
  #locality_lb_policy       = "ORIGINAL_DESTINATION"
  backend {
    group                   = data.google_compute_region_instance_group.public.self_link
    #balancing_mode         = "CONNECTION"
    #max_connections_per_instance  = "30"
    #max_connections        = "50"
  }
  health_checks             = [google_compute_health_check.ppublic-autohealing.id]
}

#--------------------------------------------------------#
# Create compute autohealing policy for nginx instances  #
#--------------------------------------------------------#

resource "google_compute_health_check" "ppublic-autohealing" {
  name                          = "ppublic-autohealing"
  check_interval_sec            = "5"
  timeout_sec                   = "5"
  healthy_threshold             = "2"
  unhealthy_threshold           = "2"

  http_health_check {
    port                        = "80"
  }
}
