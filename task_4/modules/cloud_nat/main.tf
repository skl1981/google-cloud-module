# ======================Create CLOUD NAT ======================================
resource "google_compute_router" "default" {
  name    = "${var.name}-router"
  network = var.network
}

resource "google_compute_router_nat" "default" {
  name                               = "${var.name}-router-nat"
  router                             = google_compute_router.default.name
  region                             = google_compute_router.default.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
