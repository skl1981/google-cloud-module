#!/bin/bash
# Installs Postgres and enable

sudo apt-get install postgresql -y
sudo postgresql-setup initdb
sudo echo "listen_addresses = '0.0.0.0'" >> /etc/postgresql/9.6/main/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/9.6/main/pg_hba.conf 
sudo systemctl enable postgresql
sudo systemctl restart postgresql