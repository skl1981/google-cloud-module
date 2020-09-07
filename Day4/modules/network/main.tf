resource "google_compute_network" "vpc_network" {
  name = "${var.student_name}-vpc"
  description = "Custom network"
  auto_create_subnetworks = "false"  
}
