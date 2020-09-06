#project = "amplified-coder-288007"

my_name = "Valiantsin"
my_surname = "Ratomski"

image = "centos-cloud/centos-7"
multi-zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
region = "us-central1"
machine-type = "n1-standard-1"
nginx-instance-prefix = "nginx-instance-"
group-manager-nginx-name = "nginx-server"
sub-public-name = "sub-public"
sub-private-name = "sub-private"

# plus postgres vars
postgres-instance-prefix = "postgres-instance-"
group-manager-postgres-name = "postgres-server"
base-instance-name-n = "nginx-instance"
base-instance-name-p = "postgres-instance"
nginx-autoscaler-name = "nginx-autoscaler-name"

ext-tags = ["external-22", "external-80"]

ssh-user = "ubuntu"
ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsgPL4xcYRKgQFz9W8xQ9mnWc9WMZxu2skx121st/f7w7QsEn4L++TCt77vsJ1nqRtfxF/MmXeC326QPulYW7YnOXTcGtmfuZQDVP72EBifglXBIz/CL0ChNfOLK7D5yH9SVpBJfKMU0XsWU+ObzEEpsPXbtC0kZahLRIroBuQjsV5gsaIVDiqIa2ztK1fDSKFXT9AfX1gnlll2Pp0JmVJbqi8gWnouS9Am10hZXm2HpCESBB4dZ9s2ZkYgWKZrXrIFO33ES/2IrLr2MdAsGjMBTlS57c5VSSqCP6PRZ7n08WM3wt41WmT+1EFof+XXgtWvCP95bY9gO2PGpoby15L aliaksandr_mazurenka"