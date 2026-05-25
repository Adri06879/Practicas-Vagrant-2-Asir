#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "=== Instalando MySQL Server ==="
apt-get install -y mysql-server

echo "=== Configurando MySQL para acceso remoto ==="
# Habilitar la escucha en todas las interfaces de red (0.0.0.0)
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl restart mysql

echo "=== Creando base de datos y usuario ==="
mysql <<EOF
CREATE DATABASE IF NOT EXISTS wordpress_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Crear usuario estricto para la subred privada (Seguridad MySQL)
CREATE USER IF NOT EXISTS 'wp_user'@'192.168.56.%' IDENTIFIED BY 'wp_secure_pass';

-- Otorgar permisos específicos a la BD de wordpress
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'192.168.56.%';
FLUSH PRIVILEGES;

-- Verificaciones de control en el log de Vagrant
SHOW DATABASES;
SELECT User, Host FROM mysql.user;
EOF

echo "=== MySQL configurado correctamente ==="