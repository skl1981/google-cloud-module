output "Bastion_ssh_connection_to_web_server" {
    value = <<EOT

    To connect to web server through bastion:
    ssh -J ${var.gcp_user}@${module.network.nat_ip} ${var.gcp_user}@10.1.1.3 (or other instance IP in VPC)

    EOT
}
output "WebSite" {
  value = "http://${module.http_lb.http_url}"
}
output "Bastion" {
  value = "ssh ${var.gcp_user}@${module.network.nat_ip} (add -i /path/to/private_key if necessary)"
}
output "PostgresLB_Internal_IP" {
  value = <<EOT
  to test connection, do 
  psql -Upostgres -h${module.postgres_lb.postgres_lb} 
  from web-* instance (\q to quit)
  EOT
}
