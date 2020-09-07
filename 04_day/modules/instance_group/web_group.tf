/*provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}*/

// =================create template for web group=================

resource "google_compute_instance_template" "webserver" {
  name                 = "${var.web_name}-template"
  tags                 = var.web_ins_tags
  machine_type         = var.machine_type_web
  disk {
    source_image       = var.image_web
  }
  network_interface {
    network            = var.net_name
    subnetwork         = var.subnet_for_web
  }
  metadata_startup_script = templatefile(var.web_script, { 
    name               = "${var.student_name}"
    surname            = "${var.student_surname}" })
  metadata = {
    ssh-keys           = "${var.ssh_user_name}:${file(var.ssh_key_name)}"
  } 
}


//  =================create health-check for web group=================

resource "google_compute_health_check" "autohealing" {
  name                = "${var.web_name}-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 

  http_health_check {
    request_path      = "/"
    port              = var.web_hc_port
  }
}


// =================create for web instance group=====================

resource "google_compute_region_instance_group_manager" "webserver" {
  name = "${var.web_name}-igm"
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