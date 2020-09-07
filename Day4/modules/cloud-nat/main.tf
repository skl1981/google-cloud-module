resource "google_compute_router" "router" {
  name    = "my-router"
  region  = var.region
  network = var.network_name
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name  =  var.subnetwork_name_public
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  subnetwork {
    name = var.subnetwork_name_private
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
}
}
