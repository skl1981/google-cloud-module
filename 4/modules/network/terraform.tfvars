#project = "amplified-coder-288007"
region = "us-central1"

student_name = "vratomski"
student_IDnum = 11

#firewall 
fw-ext-p80-name = "external-80"
fw-ext-p22-name = "external-22"
fw-int-name = "internal"
port-80 = ["80"]
port-22 = ["22"]
internal-ports = ["5432", "22"]
tag-ext-80 = ["external-80"]
tag-ext-22 = ["external-22"]
all-source-ranges = ["0.0.0.0/0"]

#sunets
sub-public-name = "sub-public"
sub-private-name = "sub-private"

#fw rules for healthcheck
fw-ext-lb-name = "external-lb"
fw-int-lb-name = "internal-lb"
port-5432 = ["5432"]
hc-source-ranges = ["130.211.0.0/22", "35.191.0.0/16"]

