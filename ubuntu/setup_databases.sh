# Setup MySql
sudo apt -y install mysql-server \
                    expect
sudo systemctl start mysql
sudo systemctl enable mysql

SECURE_MYSQL=$(expect -c "
  set timeout 10
  spawn mysql_secure_installation
  expect \"Enter current password for root (enter for none):\"
  send \"\r\"
  expect \"Change the root password?\"
  send \"n\r\"
  expect \"Remove anonymous users?\"
  send \"y\r\"
  expect \"Disallow root login remotely?\"
  send \"y\r\"
  expect \"Remove test database and access to it?\"
  send \"y\r\"
  expect \"Reload privilege tables now?\"
  send \"y\r\"
  expect eof
")
echo "$SECURE_MYSQL"
unset SECURE_MYSQL