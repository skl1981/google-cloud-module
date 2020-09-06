output "Afore_ssh" {
    value = <<EOT

    Before ssh connection, please execute following commands:
    eval `ssh-agent`
    ssh-add ~/.ssh/google_compute_engine

    EOT
}
output "WebSite" {
  value = "http://${module.http_lb.http_url}"
}
output "Bastion" {
  value = "ssh -A ${var.gcp_user}@${module.network.nat_ip}" 
}
output "PostgresLB_Internal_IP" {
  value = <<EOT
  to test connection, do 
  psql -Upostgres -h${module.postgres_lb.postgres_lb} 
  from web-* instance
  EOT
}
