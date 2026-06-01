#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y mysql-server

# Permitir conexiones remotas
sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

# Configuración de BD
mysql -e "CREATE DATABASE IF NOT EXISTS web_db;"
mysql -e "CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON web_db.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Crear tabla para el contador
mysql -e "USE web_db; CREATE TABLE IF NOT EXISTS contador (id INT PRIMARY KEY, visitas INT);"
mysql -e "USE web_db; INSERT IGNORE INTO contador (id, visitas) VALUES (1, 0);"