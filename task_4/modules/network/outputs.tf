output "network_name" {
  value = google_compute_network.default.name
}
output "public_subnet_name" {
  value = google_compute_subnetwork.public_subnet.name
}
output "private_subnet_name" {
  value = google_compute_subnetwork.private_subnet.name
}
output "public_subnet_cidr_range" {
  value = google_compute_subnetwork.public_subnet.ip_cidr_range
}
output "private_subnet_cidr_range" {
  value = google_compute_subnetwork.private_subnet.ip_cidr_range
}
output "create_bastion" {
  value = var.create_bastion
}
output "bastion_external_ip" {
  value = var.create_bastion ? element(google_compute_instance.bastion[*].network_interface[0].access_config[0].nat_ip, 0) : ""
}