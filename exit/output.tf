output "web-site" {
  value = module.http_load_balancer.bal
}
output "bastion" {
  value = module.instance.bastion
}