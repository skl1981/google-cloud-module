project       = "compact-retina-288017"
region        = "us-central1"
zone          = "us-central1-a"
machine_type  = "custom-1-4608"
disk_type     = "pd-ssd"
disk_size     = 35

student_name    = "dkramich"
external_ports  = ["80", "22"]
external_ranges = ["0.0.0.0/0"]
internal_ports  = ["0-65535"]
internal_ranges = ["10.2.0.0/24"]
public_subnet   = "10.2.1.0/24"
private_subnet  = "10.2.2.0/24"
