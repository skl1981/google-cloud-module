output "vpc_net_name" {
  value = google_compute_network.vpc_net.name
}
output "public_subnet_name" {
  value = google_compute_subnetwork.vpc_subnet_public.name
}
output "private_subnet_name" {
  value = google_compute_subnetwork.vpc_subnet_private.name
}
output "jump_ip" {
  value = google_compute_instance.jumphost.network_interface.0.access_config.0.nat_ip
}