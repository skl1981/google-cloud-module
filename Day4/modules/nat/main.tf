resource "google_compute_router" "router" {
  name    = var.mod_router_name
  network = var.mod_router_vpc_name
}

resource "google_compute_router_nat" "nat" {
  name                               = var.mod_nat_name
  router                             = var.mod_router_name
  nat_ip_allocate_option             = var.mod_nat_ip_option
  source_subnetwork_ip_ranges_to_nat = var.mod_nat_subnetwork_ip_ranges
}