#!/bin/bash
# Instalación completa de Docker + ntfy
# Compatible con Ubuntu Server 24.04
# Ejecutar como root

set -e

# 1. Actualizar e instalar dependencias
apt-get update -y
apt-get install -y ca-certificates curl gnupg

# 2. Configurar repositorio de Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

# 3. Instalar Docker
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Habilitar servicio
systemctl enable --now docker

# 5. Ejecutar ntfy con tus parámetros (usando el puerto 8081)
# He añadido --restart=always para que inicie al encender el servidor
docker run -d \
  --name ntfy \
  --restart=always \
  -v /var/cache/ntfy:/var/cache/ntfy \
  -p 8081:80 \
  binwiederhier/ntfy \
  serve \
  --cache-file /var/cache/ntfy/cache.db

echo ""
echo "--------------------------------------------------------"
echo "Instalación completada."
echo "Accede a la interfaz en: http://$(hostname -I | awk '{print $1}'):8081"
echo "--------------------------------------------------------"
