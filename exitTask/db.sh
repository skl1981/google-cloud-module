#!/bin/bash

sudo yum install -y postgresql-server postgresql-contrib
sudo postgresql-setup initdb
sudo sed -i "s/.*listen_addresses =.*/listen_addresses = '*'/" /var/lib/pgsql/data/postgresql.conf
sudo echo "host    all         all        0.0.0.0/0     trust" >> /var/lib/pgsql/data/pg_hba.conf
sudo systemctl enable postgresql
sudo systemctl start postgresql