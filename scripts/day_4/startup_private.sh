#!/bin/bash

sudo apt-get update
sudo apt-get install postgresql -y
sudo echo "listen_addresses = '*'" >> /etc/postgresql/9.6/main/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/9.6/main/pg_hba.conf 
sudo systemctl enable postgresql
sudo systemctl restart postgresql
