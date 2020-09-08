////////////////////////////////////
///create template for web-server///
////////////////////////////////////

resource "google_compute_instance_template" "w-srv" {
  name = "w-srv-template"
  description = "This template is used to create web server instances."
  tags = ["web"]
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
    subnetwork = var.subnet_for_web
  }
  metadata_startup_script = templatefile("web.sh", { 
    name = "${var.student_name}"  
    surname = "${var.student_surname}" })
  metadata = {
    ssh-keys = "centos7:${file("key.pub")}"
  } 
}

////////////////////////////
///create the group of VM///
////////////////////////////

resource "google_compute_region_instance_group_manager" "w-srv" {
  name = "w-srv-igm"
  base_instance_name = var.base_inst_name_web
  region = var.region
  version {
    instance_template = google_compute_instance_template.w-srv.id
  }
  target_size = var.count_ins_web
}
