variable project {}

variable region {}

variable zone {}

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
}

variable tags {
    type = list
}

variable network {}

variable del_prot {
    default = true
}