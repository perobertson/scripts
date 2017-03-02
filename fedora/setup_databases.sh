# Setup Postgres
sudo dnf -y install postgresql \
                    postgresql-contrib \
                    postgresql-devel \
                    postgresql-server
sudo postgresql-setup --initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo su --command="perl -p -i -e 's/host([\w :\/\.]*)ident/host\$1trust/g' /var/lib/pgsql/data/pg_hba.conf" --login postgres
sudo su --command="psql --command='CREATE ROLE $(whoami) WITH SUPERUSER LOGIN;'" --login postgres
