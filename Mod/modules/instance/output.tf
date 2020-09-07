output "bastion_ssh" {
  value = google_compute_instance.default1.network_interface.0.access_config.0.nat_ip
}
