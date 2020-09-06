/*provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}*/


// =================create template for web group=================

resource "google_compute_instance_template" "webserver" {
  name                 = "webserver-template"
  description          = "This template is used to create web server instances."
  tags                 = ["web"]
  instance_description = "description assigned to instances"
  machine_type         = var.machine_type
  scheduling {
    automatic_restart  = true
  }
  disk {
    source_image  = "${var.image_project}/${var.image_family}"
    auto_delete   = true
    boot          = true
  }
  network_interface {
    network       = var.net_name
    subnetwork    = var.subnet_for_web
  }
  metadata_startup_script = templatefile("script_web.sh.tpl", { 
    name    = "${var.student_name}"  
    surname = "${var.student_surname}" })
  metadata = {
    ssh-keys              = "ubuntu:${file("key.pub")}"
  } 
}


//  =================create health-check for web group=================

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}


// =================create for web instance group=====================

resource "google_compute_region_instance_group_manager" "webserver" {
  name = "webserver-igm"
  base_instance_name  = var.base_inst_name_web
  region              = var.region
  version {
    instance_template = google_compute_instance_template.webserver.id
  }
  target_size         = var.count_ins_web
  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}