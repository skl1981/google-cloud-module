output "Bastion" {
  value = module.network.create_bastion ? "ssh ${var.ssh_username}@${module.network.bastion_external_ip}" : "Bastion Host is not up"
}
output "WebSite" {
  value = "http://${module.http_lb.lb_ip}"
}
