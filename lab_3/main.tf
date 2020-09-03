provider "google" {
    credentials = file("/home/mee/gcp/terraform-admin.json")  
    project     = var.project
    region      = var.instance_region
}

resource "google_compute_instance" "vm_instance" {
    name         = var.instance_name
    machine_type = var.machine_type
    zone         = var.instance_zone
    description	 = "Create Googlce Compute Instance"
    allow_stopping_for_update = var.instance_allow_stopping_for_upd

    metadata_startup_script = templatefile("run.sh", {student_name = var.student_name})

  boot_disk {
    initialize_params {
        image    = "${var.image_project}/${var.image_family}"
      }
    }

  network_interface {
    subnetwork   = google_compute_subnetwork.vpc_subnet_public.id
    access_config {
    }
  }
}


resource "google_compute_network" "vpc_net" {
    name          = "${var.student_name}-vpc"
    auto_create_subnetworks = false
    description   = "Create vpc-network"
}


resource "google_compute_firewall" "vpc_net_external" {
    name          = var.vpc_net_external_name 
    network       = google_compute_network.vpc_net.name
    description   = "Create Firewall rules for external Network"
    allow {
      protocol    = var.vpc_net_external_allow_protocol
      ports       = var.vpc_net_external_allow_ports
    }
    source_ranges = var.vpc_net_external_source_ranges
}


resource "google_compute_firewall" "vpc_net_internal" {
    name          = var.vpc_net_internal_name 
    network       = google_compute_network.vpc_net.name
    description   = "Create Firewall rules for internal Network"
 
    allow {
        ports     = var.vpc_net_internal_allow_ports_t
        protocol  = var.vpc_net_internal_allow_protocol_t
      }
    allow {
        ports     = var.vpc_net_internal_allow_ports_u
        protocol  = var.vpc_net_internal_allow_protocol_u
    }
    allow {
        protocol  = var.vpc_net_internal_allow_protocol_a
    }
    source_ranges = var.vpc_net_internal_source_ranges
}



resource "google_compute_subnetwork" "vpc_subnet_public" {
    name          = var.vpc_subnet_public_name
    ip_cidr_range = var.vpc_subnet_public_ip_cidr_range
    network       = google_compute_network.vpc_net.id
    description   = "Create Public Subnet"
}


resource "google_compute_subnetwork" "vpc_subnet_private" {
    name          = var.vpc_subnet_private_name    
    ip_cidr_range = var.vpc_subnet_private_ip_cidr_range
    private_ip_google_access = true
    network       = google_compute_network.vpc_net.id
    description   = "Create Private Subnet"
}

output "URL" {
  value = "http://${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}

variable "project" {}
variable "instance_region" {}
variable "instance_zone" {}
variable "instance_name" {}
variable "machine_type" {}
variable "image_project" {}
variable "image_family" {}
variable "student_name" {}
variable "student_IDnum" {}

variable "instance_allow_stopping_for_upd" {
  type  = bool
}

variable "vpc_net_external_name" {}
variable "vpc_net_external_allow_protocol" {}
variable "vpc_net_external_allow_ports" {
  type  = list
}
variable "vpc_net_external_source_ranges" {
  type  = list
}

variable "vpc_net_internal_name" {}
variable "vpc_net_internal_allow_protocol_t" {}
variable "vpc_net_internal_allow_protocol_u" {}
variable "vpc_net_internal_allow_protocol_a" {} # how 2 set type=list
variable "vpc_net_internal_allow_ports_t" {
  type  = list
}
variable "vpc_net_internal_allow_ports_u" {
  type  = list
}
variable "vpc_net_internal_source_ranges" {
  type  = list
}

variable "vpc_subnet_public_name" {}
variable "vpc_subnet_public_ip_cidr_range" {}

variable "vpc_subnet_private_name" {}
variable "vpc_subnet_private_ip_cidr_range" {}
