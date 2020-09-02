output "Instance" {
  value = <<SSHCONFIG

  name: ${google_compute_instance.default.name}
  ip: ${google_compute_instance.default.network_interface[0].access_config[0].nat_ip}
  in network: ${google_compute_network.vpc_network.name}
  ${google_compute_network.vpc_network.description}
  SSHCONFIG
}
