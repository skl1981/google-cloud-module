#! /bin/bash
sudo yum install -y postgresql-server postgresql-contrib
sudo postgresql-setup initdb
echo "listen_addresses = '*'" >>  /var/lib/pgsql/data/postgresql.conf
echo "host    all             all             0.0.0.0/0   	         trust" >> /var/lib/pgsql/data/pg_hba.conf
sudo systemctl start postgresql
sudo systemctl enable postgresql