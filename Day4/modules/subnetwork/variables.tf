variable network_range{
description = "network range of custom network for firewalls rule"
default = "10.8.0.0/16"
}
variable network_name{
default = "nrabeichykava-vpc"
}
variable subnetwork_range {
description = "subnetwork of custom network"
default = "10.8.1.0/24"
}
variable region {
description = "region of subnetwork"
default =  "us-central1"
}
variable subnetwork_name {
default = "public"
description = "name of subnetwork"
}
