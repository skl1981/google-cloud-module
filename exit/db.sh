#!/bin/bash
sudo yum update
sudo yum install -y postgresql-server postgresql-contrib
sudo postgresql-setup initdb
sudo sed "s/.*listen_addresses =.*/listen_addresses = '*'/" -i /var/lib/pgsql/data/postgresql.conf
sudo systemctl start postgresql
sudo systemctl enable postgresql