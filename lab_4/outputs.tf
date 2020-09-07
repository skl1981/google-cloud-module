output "Jump-Host" {
  value = "ssh ${var.ssh_username}@${module.vpc_net.jump_ip}"
}
output "URL" {
  value = "http://${module.loadbalancer_web.loadbalancer_ip}"
}
