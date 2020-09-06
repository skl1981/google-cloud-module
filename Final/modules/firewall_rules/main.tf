# allow internal icmp and ssh
resource "google_compute_firewall" "allow-internal" {
  name    = var.fr_1_name
  network = var.network
  allow {
    protocol = var.icmp_prot
  }
  allow {
    protocol = var.tcp_prot
    ports    = [var.ssh_port]
  }
  target_tags = [var.tag_http,var.tag_postgres]
  source_tags = [var.tag_jump_host]
}
# Allow http
resource "google_compute_firewall" "allow-http" {
  name    = var.fr_2_name
  network = var.network
  allow {
    protocol = var.tcp_prot
    ports    = [var.http_port]
  }
  target_tags = [var.tag_http] 
}
# Allow http for health-check
resource "google_compute_firewall" "allow-http-health-check" {
  name    = var.fr_3_name
  network = var.network
  allow {
    ports    = [var.http_port]
    protocol = var.tcp_prot
  }
  source_ranges = var.health_ranges
  target_tags = [var.tag_http]
  description   = "rule for http health checker"
}
# Allow health-check for postgres
resource "google_compute_firewall" "postgres-health-check" {
  name    = var.fr_4_name
  network = var.network
  allow {
    ports    = [var.postgres_port]
    protocol = var.tcp_prot
  }
  source_ranges = var.health_ranges
  target_tags = [var.tag_postgres]
  description   = "rule for postgres health checker"
}
#allow external connections to jump-host
resource "google_compute_firewall" "external" {
  name    = var.fr_5_name
  network = var.network
  allow {
    protocol = var.tcp_prot
  }
  allow {
      protocol = var.udp_prot
  }
  allow {
      protocol = var.icmp_prot
  }
  target_tags = [var.tag_jump_host]
  source_ranges = var.all_ranges
  description   = "rules for external connections, allows all connections to jump-host"
}
# deny ssh to jump-host from vpc
resource "google_compute_firewall" "deny-internal" {
  name    = var.fr_6_name
  network = var.network
  deny {
    protocol = var.tcp_prot
    ports    = [var.ssh_port]
  }
  target_tags = [var.tag_jump_host]
  source_tags = [var.tag_http,var.tag_postgres]
}
#allow 5432
resource "google_compute_firewall" "allow-postgres" {
  name    = var.fr_7_name
  network = var.network
  allow {
   protocol = var.tcp_prot
    ports    = [var.postgres_port]
 }
  source_tags = [var.tag_http]
  target_tags = [var.tag_postgres] 
}
