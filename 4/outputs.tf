output "Bastion" {
  value = "ssh ${var.ssh-user}@${module.jump-host.Bastion}"
}

output "WebSite" {
  value = "http://${module.http-load-balancer.http-lb-ip}"
}