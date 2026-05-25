#!/bin/bash
set -e

echo "=== Configurando WordPress ==="
cd /var/www/html

# Crear wp-config.php a partir de la plantilla
cp wp-config-sample.php wp-config.php

# Inyectar credenciales pasadas por el entorno de Vagrant
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASS/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

echo "=== Inyectando Salt Keys oficiales ==="
# Descargar claves aleatorias únicas de la API de WordPress
SALT_KEYS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

# Usamos un script rápido en PHP para reemplazar limpiamente el bloque de salts por seguridad
php <<ENDPHP
<?php
\$wpConfigPath = '/var/www/html/wp-config.php';
\$config = file_get_contents(\$wpConfigPath);

// Capturamos las claves descargadas pasadas por Bash
\$salts = <<<'SALTS'
$SALT_KEYS
SALTS;

// Expresión regular para ubicar y reemplazar el bloque completo por defecto
\$pattern = '/#@\+.*?#@\-/s';
\$config = preg_replace(\$pattern, \$salts, \$config);

file_put_contents(\$wpConfigPath, \$config);
?>
ENDPHP

# Añadir configuraciones avanzadas al final del archivo
cat >> wp-config.php <<'EOF'

/* Configuración adicional de seguridad y optimización */
define('WP_DEBUG', false);
define('WP_AUTO_UPDATE_CORE', false);
define('DISALLOW_FILE_EDIT', true);

/* Dirección fija del sitio (IP privada del Web Server) */
define('WP_SITEURL', 'http://192.168.56.10');
define('WP_HOME', 'http://192.168.56.10');
EOF

# Aplicar propiedad estricta al archivo de configuración (Requisito Avanzado)
chown www-data:www-data wp-config.php
chmod 640 wp-config.php

echo "=== Verificando conexión a la Base de Datos desde la VM Web ==="
php -r "
try {
    \$pdo = new PDO('mysql:host=$DB_HOST;dbname=$DB_NAME', '$DB_USER', '$DB_PASS');
    echo '¡Conexión a BD remota exitosa!' . PHP_EOL;
} catch (PDOException \$e) {
    echo 'Error crítico de conexión: ' . \$e->getMessage() . PHP_EOL;
    exit(1);
}
"

# Copiar y activar nuestro VirtualHost de Apache personalizado
cp /vagrant/config/wordpress.conf /etc/apache2/sites-available/wordpress.conf
a2dissite 000-default.conf
a2ensite wordpress.conf
systemctl restart apache2

echo "=== WordPress configurado correctamente ==="
echo "Accede localmente desde tu Host en: http://localhost:8080"