output "bastion" {
  value = "ssh ${var.ssh_user}@${module.instance.bastion_external_ip}"
}

output "web_site" {
  value = "http://${module.http_lb.http-lb}"
}
