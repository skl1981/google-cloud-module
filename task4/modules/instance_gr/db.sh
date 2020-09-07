#!/bin/bash

sudo apt-get install postgresql -y
IP=`ip addr list eth0 | grep "  inet " | head -n 1 | cut -d " " -f 6 | cut -d / -f 1`
sudo echo "listen_addresses = '$IP'" >> /etc/postgresql/9.6/main/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/9.6/main/pg_hba.conf 
sudo systemctl enable postgresql
sudo systemctl restart postgresql