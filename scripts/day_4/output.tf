output "Bastion" {
  value = "ssh ${var.ssh_user}@${module.instances.bastion_ssh}"
}

output "WebSite" {
  value = "http://${module.nginx_loadbalancer.ip_http_loadbalancer}"
}

