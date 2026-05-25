PE02 - Infraestructura WordPress Multi-máquina
📌 Descripción

Proyecto de despliegue de una infraestructura WordPress utilizando dos máquinas virtuales:

web-server → Apache + PHP + WordPress
db-server → MySQL 8.0

Ambas máquinas se comunican mediante una red privada configurada con Vagrant y VirtualBox.

🏗️ Arquitectura
HOST → localhost:8080
        │
        ▼
┌─────────────────┐
│   web-server    │
│ 192.168.56.10   │
│ Apache + PHP    │
│ WordPress       │
└────────┬────────┘
         │
 Private Network
         │
┌────────▼────────┐
│    db-server    │
│ 192.168.56.20   │
│ MySQL 8.0       │
└─────────────────┘
⚙️ Tecnologías
Vagrant
VirtualBox
Apache 2.4
PHP 7.4+
MySQL 8.0
WordPress
📁 Estructura
PE02_wordpress/
├── Vagrantfile
├── README.md
└── scripts/
    ├── common.sh
    ├── install-db.sh
    ├── install-web.sh
    └── configure-wordpress.sh
🚀 Despliegue
Levantar las máquinas
vagrant up
Verificar estado
vagrant status
Verificar conectividad
vagrant ssh web -c "ping -c 3 db-server"
Acceder a WordPress

Abrir en el navegador:

http://localhost:8080
🔐 Base de datos
Parámetro	Valor
Base de datos	wordpress_db
Usuario	wp_user
Contraseña	wp_secure_pass
🛠️ Scripts
common.sh → Configuración común
install-db.sh → Instalación MySQL
install-web.sh → Instalación Apache, PHP y WordPress
configure-wordpress.sh → Configuración automática de WordPress
✅ Requisitos cumplidos
 Infraestructura multi-máquina
 MySQL remoto
 WordPress funcional
 Provisioning automatizado
 Red privada configurada
👨‍💻 Autor

Delgado Campos