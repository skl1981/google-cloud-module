#####################################################################
# Creating template for HTTP lb

resource "google_compute_instance_template" "web_server" {
  name_prefix  = "instance-template-web-server"
  machine_type = "n1-standard-1"

  disk {
    source_image = var.image
    boot         = true
  }

  network_interface {
    network    = "${var.student_name}-vpc"
    subnetwork = var.subnet_public_name
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = ["web"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("id_rsa.pub")}"
  }

  metadata_startup_script = <<SCRIPT
    sudo yum update
    sudo yum install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "<h1>Hello from ${var.student_name}</h1>" > /usr/share/nginx/html/index.html
SCRIPT
}

#####################################################################
# Creating instance group web

resource "google_compute_region_instance_group_manager" "web_server" {
  name = "web-server"

  base_instance_name        = "web-server-group"
  region                    = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  target_size               = "1"

  version {
    instance_template = google_compute_instance_template.web_server.id
  }


  named_port {
    name = "web"
    port = 80
  }
}

#####################################################################
# Creating template for internal lb

resource "google_compute_instance_template" "db_server" {
  name_prefix  = "instance-template-db-server"
  machine_type = "n1-standard-1"
  region       = "us-central1"

  disk {
    source_image = var.image
    boot         = true
  }

  network_interface {
    network    = "${var.student_name}-vpc"
    subnetwork = var.subnet_private_name
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = ["db"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("id_rsa.pub")}"
  }
  metadata_startup_script = <<SCRIPT
    sudo yum update
    sudo yum install -y postgresql-server postgresql-contrib
    sudo postgresql-setup initdb
    sudo sed "s/.*listen_addresses =.*/listen_addresses = '*'/" -i /var/lib/pgsql/data/postgresql.conf
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
SCRIPT
}



#####################################################################
# Creating instance group db

resource "google_compute_region_instance_group_manager" "db" {
  name                      = "db"
  base_instance_name        = "db-server-group"
  region                    = "us-central1"
  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  target_size               = "3"

  version {
    instance_template = google_compute_instance_template.db_server.id
  }


  named_port {
    name = "db"
    port = 5432
  }

  named_port {
    name = "ssh"
    port = 22
  }
}
