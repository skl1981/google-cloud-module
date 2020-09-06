#!/bin/bash
sudo yum install postgresql-server postgresql-contrib -y
sudo postgresql-setup initdb
echo "listen_addresses = '*'" | sudo tee --append /var/lib/pgsql/data/postgresql.conf
echo -e "# localnet \n host  all  all  10.11.1.24/16 trust" | sudo tee --append /var/lib/pgsql/data/pg_hba.conf
sudo systemctl start postgresql