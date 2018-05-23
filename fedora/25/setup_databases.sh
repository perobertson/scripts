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

virttype="$(sudo virt-what)"
case "$virttype" in
    '') # Bare Metal
        disable_postgres
        ;;
    'virtualbox')
        setup_postgres
        ;;
    *)
        echo "[WARN] Unknown virtualization detected: $virttype skipping configuration of postgres"
        ;;
esac

# Setup MySql
# Just the header files, applications should use containters
sudo dnf -y install mysql-community-devel
