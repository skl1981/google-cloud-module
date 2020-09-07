output "bastion_ssh" {
  value = "ssh aliaksandr_mazurenka@${module.instance.bastion_ssh}"
}
output "web_site" {
  value = "http://${module.http_load_balancer.http_ip}"
}
