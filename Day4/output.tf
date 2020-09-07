output "Bastion" {
  value = "ssh ${var.ssh_user}@${module.jump_host_create.jump_host_external_ip}"
}

output "WebSite" {
  value = "http://${module.http_lb_create.http-lb-ip}"
}