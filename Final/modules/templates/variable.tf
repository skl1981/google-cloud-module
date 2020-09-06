variable "nginx_name" {
    default = "http"
}
variable "region" {
    default = "us-central1"
}
variable "nginx_machine" {
    default = "n1-standard-1"
}
variable "nginx_image" {
    default = "centos-cloud/centos-7"
}
variable "bool" {
    default = true
}
variable "nginx_disk_size" {
    default = "20"
}
variable "nginx_disk_type" {
    default = "pd-ssd"
}
variable "meta_ssh_key" {
    default = {
        ssh-keys = "user:key"
    }
}
variable "nginx_script" {
    default = <<SCRIPT
        sudo yum update
        sudo yum install -y nginx
        echo 'Hello from Alexey Afanasenko' > /usr/share/nginx/html/index.html 
        sudo systemctl enable nginx
        sudo systemctl start nginx
        sudo yum install -y install postgresql-server
        sudo systemctl enable postgresql
    SCRIPT
}
variable "network" {
    default = "my-vpc"
}
variable "nginx_subnet" {
    default = "public-subnet"
}

variable "postgres_name" {
    default = "postgres"
}
variable "postgres_machine" {
    default = "n1-standard-1"
}
variable "postgres_image" {
    default = "centos-cloud/centos-7"
}
variable "postgres_disk_size" {
    default = "20"
}
variable "postgres_disk_type" {
    default = "pd-ssd"
}
variable "postgres_script" {
    default = <<SCRIPT
        sudo yum update
        sudo yum install -y install postgresql-server
        sudo postgresql-setup initdb
        echo "listen_addresses = '*'" | sudo tee --append /var/lib/pgsql/data/postgresql.conf
        echo -e "# localnet \n host  all  all  10.1.1.24/16 trust" | sudo tee --append /var/lib/pgsql/data/pg_hba.conf
        sudo systemctl enable postgresql
        sudo systemctl restart postgresql
    SCRIPT
}
variable "postgres_subnet" {
    default = "private-subnet"
}
