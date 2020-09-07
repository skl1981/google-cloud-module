output "network-name" {
  value = google_compute_network.vpc_network.name
}
output "sub-network-ext-name" {
  value = google_compute_subnetwork.public_sub_net.name
}
output "sub-network-int-name" {
  value = google_compute_subnetwork.privat_sub_net.name
}
