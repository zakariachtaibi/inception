#!/bin/bash

service mariadb start

until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

echo "MariaDB initialization completed successfully!"

mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

exec mysqld
