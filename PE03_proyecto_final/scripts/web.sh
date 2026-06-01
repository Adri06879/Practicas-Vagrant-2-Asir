#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-mysql

# Crear index.php dinámico
cat > /var/www/html/index.php <<'EOF'
<?php
$servername = "192.168.56.20";
$username = "admin";
$password = "password";
$dbname = "web_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Incrementar contador
$conn->query("UPDATE contador SET visitas = visitas + 1 WHERE id=1");
$result = $conn->query("SELECT visitas FROM contador WHERE id=1");
$row = $result->fetch_assoc();

echo "<h1>Cluster Web Funcionando</h1>";
echo "<h2>Servidor: " . gethostname() . "</h2>";
echo "<h3>Visitas totales: " . $row['visitas'] . "</h3>";
?>
EOF

rm -f /var/www/html/index.html
systemctl restart apache2