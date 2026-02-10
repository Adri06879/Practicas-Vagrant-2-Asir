#!/bin/bash
set -e
echo "=== Instalando Apache ==="
apt-get update
apt-get install -y apache2
a2enmod rewrite
systemctl enable apache2
systemctl start apache2