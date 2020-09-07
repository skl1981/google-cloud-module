#>>>>>> create health_check for mig       <<<<<<<<<
resource "google_compute_health_check" "health_check_site" {
  name                = "check-site"
  check_interval_sec  = 1
  timeout_sec         = 1
  healthy_threshold   = 2
  unhealthy_threshold = 10
  tcp_health_check {
    port = "80" #?????????????
  }
}
resource "google_compute_health_check" "health_check_db" {
  name                = "check-db"
  check_interval_sec  = 1
  timeout_sec         = 1
  healthy_threshold   = 2
  unhealthy_threshold = 10
  tcp_health_check {
    port = "5432" #?????????????
  }

}

resource "google_compute_firewall" "firewall_health_check" {
  name    = "firewall-health-check"
  network = "${var.network-name}"
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}
#>>>>>> create template and mig for http lb       <<<<<<<<<<

resource "google_compute_instance_template" "appsite_template" {
  name           = "appserver-template"
  description    = "This template is used to create site instances."
  machine_type   = "${var.machinetype}"
  can_ip_forward = true
  tags           = ["internet"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("dopkey.pub")} \ncmetaha17:${file("id_rsa.pub")}"
  }
  metadata_startup_script = <<EFO
#!/bin/bash
sudo su -
sudo yum install -y nginx
sudo echo "Hello from Sergei Shevtsov from $(hostname)" > /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
sudo install -y postgresql-client
EFO

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  disk {
    source_image = "${var.site-image}"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = "${var.network-name}"         #google_compute_network.vpc_network.id
    subnetwork = "${var.sub-network-ext-name}" #google_compute_subnetwork.public_sub_net.id
  }

}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"

  base_instance_name        = "app-site"
  region                    = "${var.region}"
  distribution_policy_zones = "${var.policy-zone}"
  target_size               = "${var.site-target-size}"
  version {
    instance_template = google_compute_instance_template.appsite_template.id
  }
  #name_port udalau tak kak trafik ogovoren firewall
  #  named_port {
  #    name = "http"
  #    port = 80
  #  }
  auto_healing_policies {
    health_check      = google_compute_health_check.health_check_site.id
    initial_delay_sec = 30

  }

}

#>>>>>> create template and mig for internal lb       <<<<<<<<<<

resource "google_compute_instance_template" "db_template" {
  name           = "db-template"
  description    = "This template is used to create db instances."
  machine_type   = "${var.machinetype}"
  can_ip_forward = true
  tags           = ["tointernal"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("dopkey.pub")} \ncmetaha17:${file("id_rsa.pub")}"
  }

  metadata_startup_script = <<EFO
#!/bin/bash
sudo yum install -y postgresql-server
sudo postgresql-setup initdb
sudo sed "s/.*listen_addresses =.*/listen_addresses = '*'/" -i /var/lib/pgsql/data/postgresql.conf
sudo systemctl enable postgresql
sudo systemctl start postgresql

EFO

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  disk {
    source_image = "${var.site-image}" #!!!!!!!!!
    #name         = "existing-disk"
    #image        = data.google_compute_image.my_image.self_link
    #size         = 20
    #type         = "pd-ssd"
    #zone  = "${var.zone}"
    auto_delete = true
    boot        = true
  }
  network_interface {
    network    = "${var.network-name}"         #google_compute_network.vpc_network.id
    subnetwork = "${var.sub-network-int-name}" #google_compute_subnetwork.privat_sub_net.id
  }

}



resource "google_compute_region_instance_group_manager" "dbserver" {
  name = "dbserver-igm"

  base_instance_name        = "db-serv"
  region                    = "${var.region}"
  distribution_policy_zones = "${var.policy-zone}"
  target_size               = "${var.db-target-size}"
  version {
    instance_template = google_compute_instance_template.db_template.id
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.health_check_db.id
    initial_delay_sec = 30
  }
  #  update_policy {
  #    type                  = "PROACTIVE"
  #    minimal_action        = "REPLACE"
  #    max_surge_percent     = 10
  #    max_unavailable_fixed = 2
  #    min_ready_sec         = 30
  #  }

}
