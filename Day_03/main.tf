#do 
#export GOOGLE_CLOUD_KEYFILE_JSON=/path/to/file
#before apply
provider "google" {
  project       = var.project
  region        = var.region
}

#Network settings
resource "google_compute_network" "vpc_network" {
  name          = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description    = "Custom virtual private network for task 3"
}
##subnets
resource "google_compute_subnetwork" "public" {
  name          = "public-subnet"
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  description   = "Public subnet for ${var.student_name}-vpc network"  
}
resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  description   = "Private subnet for ${var.student_name}-vpc network"  
}
##firewall rules
resource "google_compute_firewall" "external" {
  name    = "external-fwr"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "rules for external connections, allows http and ssh"
}
resource "google_compute_firewall" "internal" {
  name    = "internal-fwr"
  network = google_compute_network.vpc_network.name
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  source_ranges = ["10.${var.student_IDnum}.0.0/16"]
  description   = "rules for internal connections"
}

#create instance
resource "google_compute_instance" "task3" {
    name = var.name
    zone = var.zone
    machine_type = "n1-standard-1"
    description = "Centos 7 with installed nginx"
  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.disk_type
    }
  }
  metadata_startup_script = <<SCRIPT
       sudo yum update
       sudo yum install -y nginx
       echo "Hello from ${var.student_name}" > /usr/share/nginx/html/index.html 
       sudo systemctl enable nginx
       sudo systemctl start nginx
    SCRIPT
  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public.name
    access_config {
    }
  }
}
