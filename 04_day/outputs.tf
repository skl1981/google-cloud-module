output "web-site" {
  value = module.http_balancer.lb-ip
}

output "bastion" {
  value = module.instance.bastion
}