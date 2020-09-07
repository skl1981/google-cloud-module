
resource "google_compute_instance_template" "web_server" {
  name                      = "${var.prefix_web}-template"
  description               = "This template is for ${var.prefix_web}-instances"
  instance_description      = "description assigned to instances"
  tags                      = ["${var.prefix_web}"]
  machine_type              = var.machine_type
  metadata                  = {
    ssh-keys                = "${var.ssh_key}"
  }
  scheduling {
    automatic_restart       = true
  }
  metadata_startup_script   = templatefile("run_web.sh", {
    studentName             = "${var.student_name}" 
    studentSurname          = "${var.student_surname}"
  })
  disk {
    source_image            = "${var.image_project}/${var.image_family}"
  }
  network_interface {
    network                 = var.network
    subnetwork              = var.web_subnetwork
  }
  lifecycle {
    create_before_destroy   = true
  }
}

resource "google_compute_region_instance_group_manager" "manager_web_server" {
  name                      = "${var.prefix_web}-instance-group"
  base_instance_name        = "${var.prefix_web}-instance"
  region                    = var.region
  target_size               = var.web_instance_count
  auto_healing_policies {
    health_check            = google_compute_health_check.healthckeck_web.id
    initial_delay_sec       = var.web_a_heal_policies_delay_sec
  }
  version {
    instance_template       = google_compute_instance_template.web_server.id
  }
}

resource "google_compute_health_check" "healthckeck_web" {
  name                      = "${var.prefix_web}-healthckeck-web"
  timeout_sec               = var.web_healthckeck_timeout_sec
  check_interval_sec        = var.web_healthckeck_check_interval_sec
  healthy_threshold         = var.web_healthckeck_healthy_threshold
  unhealthy_threshold       = var.web_healthckeck_unhealthy_threshold
  http_health_check {
    port                    = var.web_healthckeck_instancegroup_port
  }
}

resource "google_compute_instance_template" "db_server" {
  name                      = "${var.prefix_db}-template"
  description               = "This template is for ${var.prefix_db}-instances"
  tags                      = ["${var.prefix_db}"]  
  instance_description      = "description assigned to instances"
  machine_type              = var.machine_type
  scheduling {
    automatic_restart       = true
  }
  disk {
    source_image            = "${var.image_project}/${var.image_family}"
    auto_delete             = true
    boot                    = true
  }
  network_interface {
    network                 = var.network
    subnetwork              = var.db_subnetwork
  }
  metadata_startup_script   = file("run_db.sh")
  metadata = {
    ssh-keys                = "${var.ssh_key}"
  }
}

resource "google_compute_health_check" "healthckeck_db" {
  name                      = "${var.prefix_db}-healthckeck-web"
  timeout_sec               = var.db_healthckeck_timeout_sec
  check_interval_sec        = var.db_healthckeck_check_interval_sec
  tcp_health_check {
    port                    = var.db_healthckeck_instancegroup_port    
  }
}

resource "google_compute_region_instance_group_manager" "dbserver" {
  name                      = "${var.prefix_db}-instance-group"
  base_instance_name        = "${var.prefix_db}-instance"  
  region                    = var.region
  target_size               = var.db_instance_count
  version {
    instance_template       = google_compute_instance_template.db_server.id
  }
  auto_healing_policies {
    health_check            = google_compute_health_check.healthckeck_db.id
    initial_delay_sec       = var.db_a_heal_policies_delay_sec
  }
}