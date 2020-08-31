variable project {
    default = "smooth-era-287810"  
}

variable region {
    default = "us-central1"
}

variable zone {
    default = "us-central1-c"
}

variable name {
    default = "nginx-terraform"
}

variable machine_type {
    default = "n1-custom-1-4608"
}

variable image {
    default = "centos-cloud/centos-7"
}

variable size {
    default = 35
}

variable disk_type {
    default = "pd-ssd"
}

variable labels {
    type = map
    default = {
        "server_type"="nginx_server",
        "os_family"="red_hat",
        "way_of_installation"="terraform"
    }
}

variable tags {
    type = list
    default = [
        "http-server",
        "https-server"
    ]
}

variable network {
    default = "default"
}

variable del_prot {
    default = true
}