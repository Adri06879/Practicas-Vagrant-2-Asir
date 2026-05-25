#!/bin/bash
set -e

echo "=== Configuración común ==="

# Actualizar sistema
apt-get update

# Instalar utilidades básicas
apt-get install -y vim curl wget net-tools dnsutils

# Configurar /etc/hosts para resolución de nombres interna
cat <<EOF > /etc/hosts
127.0.0.1 localhost
192.168.56.10 web-server
192.168.56.20 db-server
EOF

# Configurar timezone
timedatectl set-timezone Europe/Madrid

echo "=== Configuración común completada ==="
