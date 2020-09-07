student_name = "nrabeichykava"
network_range = "10.8.0.0/16"
subnetwork_range_public = "10.8.1.0/24"
subnetwork_range_private = "10.8.2.0/24"
region = "us-central1"
subnetwork_name_public = "public"
subnetwork_name_private = "private"
name_prefix = "instance-template"
machine_type = "custom-1-4608-ext"
image = "centos-cloud/centos-7"
disk_size_gb = "35"
disk_type = "pd-ssd"
metadata = {
    "ssh-keys" = "user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L user"
}
name_bastion_instance = "bastion"
bastion_zone = "us-central1-a"
bastion_tags = ["bastion"]
autoscaler = true
web_group_name = "web"
distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
web_target_size = 1
web_script =<<SCRIPT
sudo yum -y -q install epel-release
sudo yum -y -q install nginx
sudo systemctl start nginx
sudo echo "listen_addresses = '*'" | sudo tee --append /var/lib/pgsql/data/postgresql.conf
sudo echo 'Hello from Nastassia Rabeichykava!'  >/usr/share/nginx/html/index.html
SCRIPT
web_tags =  ["web"]
web_named_ports= [
    {
      name = "http"
      port = 80
    }
  ]
web_base_instance_name = "web"
db_base_instance_name = "db"
db_group_name = "db"
db_target_size = 3
db_script =<<SCRIPT
sudo yum -y -q install postgresql-server postgresql-contrib
sudo postgresql-setup initdb
sudo echo "listen_addresses = '*'" | sudo tee --append /var/lib/pgsql/data/postgresql.conf
sudo systemctl start postgresql
SCRIPT
db_tags =  ["db"]
db_named_ports= [
    {
      name = "db"
      port = 5432
    }
  ]
app_name = "app"
db_name = "postgres-lb"
health_check_port = "5432"
protocol = "TCP"
ports = ["5432"]
ip_address = null

