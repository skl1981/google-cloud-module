projectname = "my-first-lab-project1"
region      = "us-central1"


#>>>>>>> net vars
new-name-net   = "exit-sshevtsov-vpc"
publicip       = "10.109.1.0/24"
public-sub-net = "exit-public-sub-net"
privatip       = "10.109.2.0/24"
privat-sub-net = "exit-privat-sub-net"
ext-port       = ["80", "22"]
all-port       = ["0-65535"]



#>>>>>> instance vars
machinetype = "n1-standard-1"
image       = "centos-cloud/centos-7"
hdd-size    = "25"
hdd-type    = "pd-ssd"



#>>>>>>> mig vars
site-image       = "centos-cloud/centos-7"
policy-zone      = ["us-central1-a", "us-central1-b", "us-central1-c"]
site-target-size = "1"
db-target-size   = "3"



#>>>>>>> http_lb vars
http-port = "80"



#>>>>>> internal_lb vars
tcp-port              = "5432"
forwarding-rule-ports = ["5432"]
