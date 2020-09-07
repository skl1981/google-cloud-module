resource "google_compute_subnetwork" "subnetworks_create" {
  count         = length(var.mod_subnetwork_names)
  name          = lookup(var.mod_subnetwork_names, count.index)
  ip_cidr_range = lookup(var.mod_subnetwork_ip_ranges, count.index)
  network       = var.mod_subnetwork_vpc_name
  description   = "create ${lookup(var.mod_subnetwork_names, count.index)}"
}