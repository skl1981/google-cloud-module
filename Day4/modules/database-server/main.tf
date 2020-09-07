resource "google_compute_instance_template" "db_template" {
  name_prefix               = var.mod_db_template_prefix 
  machine_type              = var.mod_db_template_type
  tags                      = [var.mod_db_template_tags]
  metadata_startup_script   = file("./modules/database-server/postgres_server.sh")
  metadata = {
    ssh-keys = var.ssh_key
  }
  disk {
    source_image            = var.mod_db_template_image
  }

  network_interface {
    network                 = var.mod_db_template_network_interface
    subnetwork              = var.mod_db_template_subnetwork
  }
}

resource "google_compute_region_instance_group_manager" "db_mig" {
  name                      = var.mod_db_mig_name
  base_instance_name        = var.mod_db_mig_base_name
  distribution_policy_zones = [var.mod_db_mig_zone_a, var.mod_db_mig_zone_b, var.mod_db_mig_zone_c]
  region                    = var.mod_db_mig_region
  target_size               = var.mod_db_mig_target_size

    version {
    instance_template       = google_compute_instance_template.db_template.id
  }
}