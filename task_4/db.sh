sudo yum install postgresql-server postgresql-contrib -y
sudo postgresql-setup initdb
sudo sed "s/.*listen_addresses =.*/listen_addresses = '*'/" -i /var/lib/pgsql/data/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               trust" >> /var/lib/pgsql/data/pg_hba.conf
sudo systemctl start postgresql
sudo systemctl enable postgresql
