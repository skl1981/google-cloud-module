///////////////////////////////////
///create template for DB-server///
///////////////////////////////////

resource "google_compute_instance_template" "db-srv" {
  name = "db-srv-template"
  description = "This template is used to create web server instances."
  tags = ["db"]
  instance_description = "description assigned to instances"
  machine_type = var.machine_type
  scheduling {
    automatic_restart = true
  }
  disk {
    source_image = "${var.image_project}/${var.image_family}"
    auto_delete = true
    boot = true
  }
  network_interface {
    network = var.net_name
    subnetwork = var.subnet_for_db
  }
  metadata_startup_script = file("db.sh")
  metadata = {
    ssh-keys = "centos7:${file("key.pub")}"
  }
}

////////////////////////////
///create the group of VM///
////////////////////////////

resource "google_compute_region_instance_group_manager" "db-srv" {
  name = "db-igm"
  base_instance_name = var.base_inst_name_db
  region = var.region
  target_size = var.count_ins_db
  version {
    instance_template = google_compute_instance_template.db-srv.id
  }
}
