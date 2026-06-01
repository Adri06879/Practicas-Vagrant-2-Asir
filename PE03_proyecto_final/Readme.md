# PE03 - Proyecto Final

## Descripción

Infraestructura web con balanceo de carga usando:

- nginx
- Apache
- PHP
- MySQL
- Vagrant
- VirtualBox

## Arquitectura

| Máquina | IP | Función |
|---|---|---|
| lb | 192.168.56.10 | Balanceador nginx |
| web1 | 192.168.56.11 | Apache + PHP |
| web2 | 192.168.56.12 | Apache + PHP |
| web3 | 192.168.56.13 | Apache + PHP |
| db | 192.168.56.20 | MySQL |

## Requisitos

- VirtualBox
- Vagrant

## Ejecución

```bash

vagrant up
Verificar estado

vagrant status
Acceso web
Abrir:

http://localhost:8080
Prueba de balanceo

curl localhost:8080
Ejecutarlo varias veces.
Detener una web

vagrant halt web2
Después comprobar que sigue funcionando.
Acceso SSH

vagrant ssh web1
vagrant ssh db
Mostrar bases de datos

mysql -u usuario -ppassword -e "SHOW DATABASES;"

---

# 7. Comandos para la demostración del vídeo

## Mostrar VMs

```bash
vagrant status
Acceder a la web
Abrir navegador:
http://localhost:8080
________________________________________
Probar balanceo
curl localhost:8080
Ejecutar varias veces.
________________________________________
Entrar por SSH
vagrant ssh web1
Comprobar Apache:
systemctl status apache2
________________________________________
Verificar MySQL
vagrant ssh db
mysql -u usuario -ppassword
SHOW DATABASES;
USE clusterdb;
SELECT * FROM contador;
________________________________________
Apagar una web
vagrant halt web2
Luego:
curl localhost:8080
Demostrar que sigue funcionando.
________________________________________
