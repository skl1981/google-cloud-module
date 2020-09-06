/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/

resource "google_compute_router" "cloud-router" {
  name = var.cloud-router-name
  network = "${var.student_name}-vpc"
}

resource "google_compute_router_nat" "cloud-nat" {
  name = var.cloud-nat-name
  router = google_compute_router.cloud-router.name
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}