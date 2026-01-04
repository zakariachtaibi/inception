#!/bin/bash

# Start MariaDB service temporarily for initialization
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Create database and user if they don't exist
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

echo "MariaDB initialization completed successfully!"

# Stop the temporary MariaDB service
mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown

# Start MariaDB in the foreground
exec mysqld
