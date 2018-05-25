# Setup Postgres
sudo dnf -y install postgresql \
                    postgresql-contrib \
                    postgresql-devel \
                    postgresql-server

setup_postgres(){
    # Setup postgres when inside a VM
    sudo postgresql-setup --initdb
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    # trust all connections from the host
    sudo su --command="perl -p -i -e 's/host([\w :\/\.]*)ident/host\$1trust/g' /var/lib/pgsql/data/pg_hba.conf" --login postgres || true
    # create a db user for the currently logged in user
    sudo su --command="psql --command='CREATE ROLE $(whoami) WITH SUPERUSER LOGIN;'" --login postgres
}

disable_postgres(){
    # Applications should be using containers, but keep the server around for now
    sudo systemctl disable postgresql
}

# use grep because multiple results can be returned
if [[ "$(sudo virt-what)" = '' ]]; then
    # Bare Metal
    disable_postgres
elif [[ "$(sudo virt-what | grep virtualbox)" != '' ]]; then
    setup_postgres
elif [[ "$(sudo virt-what | grep kvm)" != '' ]]; then
    disable_postgres
else
    echo "[WARN] Unknown virtualization detected: '$(sudo virt-what)' skipping configuration of postgres"
fi

# Setup MySql
# Just the header files, applications should use containters
sudo dnf -y install mysql-community-devel
