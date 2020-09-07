output "Bastion" {
  value = <<SSHCONFIG

        1: ssh aliaksandr_mazurenka@${module.instance.jump-host}
        2: ssh cmetaha17@${module.instance.jump-host} (my_key)

WebSite: ${module.httplb.httplb-ip}:80

SSHCONFIG
}
#${google_compute_instance.default.name}
#ip: ${google_compute_instance.default.network_interface[0].access_config[0].nat_ip}
#in network: ${google_compute_network.vpc_network.name}
#${google_compute_network.vpc_network.description}
