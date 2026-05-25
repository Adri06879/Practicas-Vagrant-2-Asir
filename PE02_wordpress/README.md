# PE02 - Infraestructura WordPress Multi-máquina

## 📌 Descripción

Proyecto de despliegue de una infraestructura WordPress utilizando dos máquinas virtuales:

- **web-server** → Apache + PHP + WordPress
- **db-server** → MySQL 8.0

Ambas máquinas se comunican mediante una red privada configurada con Vagrant y VirtualBox.

---

## 🏗️ Arquitectura

```text
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
```

---

## ⚙️ Tecnologías

- Vagrant
- VirtualBox
- Apache 2.4
- PHP 7.4+
- MySQL 8.0
- WordPress

---

## 📁 Estructura

```text
PE02_wordpress/
├── Vagrantfile
├── README.md
└── scripts/
    ├── common.sh
    ├── install-db.sh
    ├── install-web.sh
    └── configure-wordpress.sh
```

---

## 🚀 Despliegue

### Levantar las máquinas

```bash
vagrant up
```

### Verificar estado

```bash
vagrant status
```

### Verificar conectividad

```bash
vagrant ssh web -c "ping -c 3 db-server"
```

---

## 🌐 Acceso

Abrir en el navegador:

```text
http://localhost:8080
```

---

## 🔐 Base de datos

| Parámetro | Valor |
|---|---|
| Base de datos | wordpress_db |
| Usuario | wp_user |
| Contraseña | wp_secure_pass |

---

## 👨‍💻 Autor

Delgado Campos