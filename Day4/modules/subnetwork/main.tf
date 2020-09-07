resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = var.subnetwork_name
  ip_cidr_range = var.subnetwork_range
  region = var.region
  network = var.network_name
  description = "subnetwork of custom network"
}

