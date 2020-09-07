#---------------------
#     GENERAL
#---------------------
project = "amplified-coder-288007"
region = "us-central1"
zone = "us-central1-b"
multi-zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

machine-type = "n1-standard-1"
image = "centos-cloud/centos-7"

student_name = "vratomski"
my_name = "Valiantsin"
my_surname = "Ratomski"
student_IDnum = 11

ssh-user = "aliaksandr_mazurenka"
ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L aliaksandr_mazurenka"

#---------------------
#     NETWORK
#---------------------
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


#---------------------
#     JUMPHOST
#---------------------
size = "35"
type = "pd-ssd"
tag-p22 = ["external-22", "internal-22"]


#---------------------
#     INSTANCE GROUP
#---------------------
nginx-instance-prefix = "nginx-instance-"
group-manager-nginx-name = "nginx-server"
postgres-instance-prefix = "postgres-instance-"
group-manager-postgres-name = "postgres-server"
base-instance-name-n = "nginx-instance"
base-instance-name-p = "postgres-instance"
nginx-autoscaler-name = "nginx-autoscaler-name"
ext-tags = ["external-22", "external-80"]


#---------------------
#     HTTP LB
#---------------------
proxy-name = "http-lb-proxy"
backend-service-name = "http-lb-backend-service"
urlmap-name = "http-lb-urlmap"
gfr-name = "http-lb-global-forwarding-rule"
health-check-name = "http-lb-health-check"


#---------------------
#     INTERNAL LB
#---------------------
fr-name = "int-lb-fr"
region-backend-service-name = "int-lb-backend-service"
int-health-check-name = "int-lb-health-check"


#---------------------
#     CLOUD NAT
#---------------------
cloud-router-name = "cloud-router"
cloud-nat-name = "cloud-nat"