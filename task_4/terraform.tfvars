project           = "devops-lab-summer"
region            = "us-central1"
ssh_username      = "centos"
ssh_key           = "ssh.pub"
http_health_check = true


# For web instance group
web_instance_startup_script = "web.sh"

# For db instance group
ig_db_name                 = "db"
db_instance_count          = "3"
db_instance_startup_script = "db.sh"
db_distribution_zones      = ["us-central1-a", "us-central1-b", "us-central1-c"]
db_health_check_port       = "5432"

