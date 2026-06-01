#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y nginx

# Crear configuración de balanceo
cat <<EOF > /etc/nginx/sites-available/default
upstream backend_servers {
    server 192.168.56.11;
    server 192.168.56.12;
    server 192.168.56.13;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend_servers;
    }
}
EOF

systemctl restart nginx