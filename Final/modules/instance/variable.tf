variable "name" {
    default = "jump-host"
}
variable "zone" {
    default = "us-central1-c"
}
variable "machine" {
    default = "n1-standard-1"
}
variable "bool" {
    default = true
}
variable "image"{
    default = "centos-cloud/centos-7"
}
variable "size" {
    default = 20
}
variable "disk_type" {
    default = "pd-ssd"
}
variable "meta_ssh_key" {
    default = {
        ssh-keys = "user:key"
    }
}
variable "script" {
    default= <<SCRIPT
        sleep 2
        sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
    SCRIPT
}
variable "network" {
    default = "my-vpc"
}
variable "subnet" {
    default = "public-subnet"
}
variable "nat_name" {
    default = "nat-router"
}
variable "tags" {
    default = ["http","postgres"]
}
variable "range" {
    default = "0.0.0.0/0"
}
variable "priority" {
    default = 800
}
variable "nat_ip" {}
variable "network_id" {}