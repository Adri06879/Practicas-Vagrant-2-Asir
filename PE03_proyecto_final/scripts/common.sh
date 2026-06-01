#!/bin/bash
# Evitar interacciones de usuario durante la instalación
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y curl vim git