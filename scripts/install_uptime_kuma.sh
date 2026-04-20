#!/bin/bash
# Instalación de Docker + Uptime Kuma
# Compatible con Ubuntu Server  24.04
# Ejecutar con privilegios de superusuario (root)


set -e  # Finaliza el script si algún comando devuelve un error


# 1. Instalar dependencias del sistema
apt-get update -y
apt-get install -y ca-certificates curl gnupg


# 2. Configurar el repositorio oficial de Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg


echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null


# 3. Instalar Docker Engine y plugins
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# 4. Habilitar y arrancar el servicio de Docker
systemctl enable --now docker


# 5. Desplegar contenedor de Uptime Kuma
# Se utiliza un volumen persistente para no perder la configuración al reiniciar
docker run -d \
    --restart=always \
    -p 3001:3001 \
    -v uptime-kuma:/app/data \
    --name uptime-kuma \
    louislam/uptime-kuma:1


echo ""
echo "Instalación completada con éxito."
echo "Accede a la interfaz web en: http://$(hostname -I | awk '{print $1}'):3001"
