#!/bin/bash

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
sudo echo "listen_addresses = '*'" >> /etc/postgresql/10/main/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/10/main/pg_hba.conf 
sudo sed -i "/5432/s/#//" /etc/postgresql/10/main/postgresql.conf 
sudo sed -i "s/(change requires restart)//" /etc/postgresql/10/main/postgresql.conf 
sudo sh -c 'echo "tcpip_socket=true" >> /etc/postgresql/10/main/postgresql.conf'
sudo systemctl enable postgresql
sudo systemctl restart postgresql
