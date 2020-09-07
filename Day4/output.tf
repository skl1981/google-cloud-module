output "Bastion"{
  value       =  "ssh user@${module.bastion.bastion_external_ip} #Please use this format to connect to other instances [ssh -J user@${module.bastion.bastion_external_ip} user@<internal-host-ip>]"
  description = "Bastion external ip address"
}
output "WebSite" {
  value = "http://${module.http-lb.load-balancer-ip-address}/   #Please wait until the site becomes up. It takes a few minutes."
  description = "Http-load-balancer ip-address"
}
output "Internal-lb" {
  value = "${module.internal-lb.internal-balancer-ip-address}           #IP-address for Internal Load-Balancer."
  description = "Internal-load-balancer ip-address"
}
