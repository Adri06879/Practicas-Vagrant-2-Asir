<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard LAMP Server</title>
    <style>
        :root {
            --primary: #4f46e5;
            --success: #10b981;
            --bg: #f3f4f6;
            --card: #ffffff;
            --text: #1f2937;
        }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--bg); 
            color: var(--text);
            margin: 0;
            padding: 20px;
        }
        .container { max-width: 900px; margin: 0 auto; }
        .header { 
            text-align: center; 
            padding: 20px 0; 
            background: var(--primary); 
            color: white; 
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }
        .grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); 
            gap: 20px; 
        }
        .card { 
            background: var(--card); 
            padding: 20px; 
            border-radius: 12px; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .card h3 { 
            margin-top: 0; 
            border-bottom: 2px solid var(--bg); 
            padding-bottom: 10px;
            color: var(--primary);
        }
        .status { 
            display: inline-block; 
            padding: 5px 12px; 
            border-radius: 20px; 
            font-size: 0.85rem; 
            font-weight: bold;
        }
        .status-ok { background: #d1fae5; color: #065f46; }
        .info-row { display: flex; justify-content: space-between; margin: 8px 0; }
        .label { font-weight: 600; color: #6b7280; }
        .footer { text-align: center; margin-top: 40px; font-size: 0.9rem; color: #9ca3af; }
        .btn {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 15px;
            transition: opacity 0.2s;
        }
        .btn:hover { opacity: 0.9; }
        .ext-list { font-size: 0.8rem; line-height: 1.6; background: #f9fafb; padding: 10px; border-radius: 8px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>🚀 Panel de Control LAMP</h1>
        <p>Servidor configurado correctamente con Vagrant</p>
    </div>

    <div class="grid">
        <div class="card">
            <h3>🖥️ Sistema Operativo</h3>
            <div class="info-row"><span class="label">Hostname:</span> <span><?php echo gethostname(); ?></span></div>
            <div class="info-row"><span class="label">IP Servidor:</span> <span><?php echo $_SERVER['SERVER_ADDR']; ?></span></div>
            <div class="info-row"><span class="label">Kernel:</span> <span><?php echo php_uname('r'); ?></span></div>
            <div class="status status-ok">En línea</div>
        </div>

        <div class="card">
            <h3>📦 Versiones Stack</h3>
            <div class="info-row"><span class="label">Apache:</span> <span>2.4.41</span></div>
            <div class="info-row"><span class="label">PHP:</span> <span><?php echo phpversion(); ?></span></div>
            <div class="info-row"><span class="label">MySQL:</span> <span>8.0.42</span></div>
            <div class="status status-ok">Actualizado</div>
        </div>

        <div class="card">
            <h3>🗄️ Base de Datos</h3>
            <?php
            try {
                $db = new PDO("mysql:host=localhost;dbname=lamp_db", "lamp_user", "lamp_pass");
                echo '<div class="info-row"><span class="label">DB Name:</span> <span>lamp_db</span></div>';
                echo '<div class="info-row"><span class="label">Usuario:</span> <span>lamp_user</span></div>';
                echo '<div class="status status-ok">✅ Conexión Exitosa</div>';
            } catch (PDOException $e) {
                echo '<div class="status" style="background:#fee2e2; color:#991b1b;">❌ Error de conexión</div>';
            }
            ?>
        </div>
    </div>

    <div class="card" style="margin-top: 20px;">
        <h3>🧩 Extensiones PHP Requeridas</h3>
        <div class="ext-list">
            <?php 
            $req = ['mysqli', 'pdo_mysql', 'curl', 'gd', 'mbstring', 'xml'];
            foreach($req as $ext) {
                $check = extension_loaded($ext) ? '✅' : '❌';
                echo "<strong>$ext:</strong> $check &nbsp; | &nbsp; ";
            }
            ?>
        </div>
        <a href="info.php" class="btn">Ver phpinfo() completo</a>
    </div>

    <div class="footer">
        &copy; <?php echo date("Y"); ?> - Proyecto PE01 Servidor LAMP - Computación en la nube
    </div>
</div>

</body>
</html>