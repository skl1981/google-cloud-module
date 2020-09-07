output "jump_host_external_ip" {
  value = "${google_compute_instance.jump_host_create.network_interface.0.access_config.0.nat_ip}"
}