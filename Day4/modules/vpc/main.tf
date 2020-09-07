resource "google_compute_network" "vpc_create" {
  name                    = var.mod_vpc_name
  auto_create_subnetworks = var.mod_vpc_auto_create_subnetworks
  description = "creating vpc network"
}