# Sistemas de Monitorización — IES Enric Soler i Godes

![Proxmox](https://img.shields.io/badge/Proxmox_VE-E57000?style=flat&logo=proxmox&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![nginx](https://img.shields.io/badge/nginx-009639?style=flat&logo=nginx&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue)

Diseño y despliegue de una infraestructura de monitorización completa sobre un entorno virtualizado con Proxmox VE, utilizando exclusivamente herramientas de código abierto. El objetivo es transformar una gestión reactiva de incidencias en un modelo proactivo: detectar anomalías antes de que afecten al servicio.

---

## Autores

| Nombre | NIA |
| :--- | :--- |
| Kevin Murciano Gadea | 10788620 |
| Sergio Ferrá Boix | 10663813 |

**Curso:** 2025-2026 · Administració de Sistemes Informàtics en Xarxa · IES Enric Soler i Godes

---

## Stack tecnológico

| Componente | Herramienta | Versión |
| :--- | :--- | :--- |
| Hipervisor | Proxmox VE | 8.x |
| Monitorización de disponibilidad | Uptime Kuma | 1.x |
| Monitorización avanzada | Pandora FMS Community | Latest |
| Notificaciones push | Gotify | Latest |
| Notificaciones HTTP | ntfy | Latest |
| Portal web centralizado | KS-Dashboard (nginx) | 1.0 |
| Contenedores | Docker Engine | Latest |
| Gestión de credenciales | KeePassXC | Latest |

Todo el software utilizado es de código abierto. No se ha adquirido ninguna licencia de pago.

---

## Arquitectura

El sistema se estructura en tres capas principales:

- **Hardware:** Servidor físico x86-64 donado por empresa de FCT.
- **Virtualización:** Proxmox VE gestiona las máquinas virtuales independientes (Ubuntu Server 24.04 y AlmaLinux 9).
- **Servicios:** Uptime Kuma y Pandora FMS envían alertas a Gotify y ntfy, que distribuyen notificaciones push a los dispositivos de los administradores.
```
Servidor físico (Prestado por el profesorado)
└── Proxmox VE (10.2.1.253)
├── VM 1 — Uptime Kuma          (10.2.1.168)
├── VM 2 — Pandora FMS          (10.2.1.167)
├── VM 3 — Gotify + ntfy        (10.2.1.169)
├── VM 4 — KS-Client            (10.2.1.163)
├── VM 5 — KS-Dashboard (VM)    (10.2.1.166)
│          KS-Dashboard (Web)   (10.2.1.165)
└── VM 6 — KS-Dashboard-Backup  (10.2.1.164)
Portal web
└── KS-Dashboard (nginx)            (10.2.1.165)
├── → Pandora FMS
├── → Uptime Kuma
├── → Gotify
└── → ntfy
```

| Componente | Función principal |
| :--- | :--- |
| Servidor físico (hardware) | Base de cómputo: CPU, RAM y almacenamiento para todas las VMs |
| Proxmox VE (hipervisor) | Virtualización de tipo 1 basada en KVM. Gestión de VMs desde interfaz web |
| VM 1 — Uptime Kuma | Monitorización de disponibilidad de servicios web y endpoints (HTTP/S, TCP, DNS) |
| VM 2 — Pandora FMS Community | Monitorización avanzada de rendimiento: CPU, RAM, red, disco. Agentes SNMP |
| VM 3 — Gotify + ntfy | Servidor de notificaciones push autoalojado. App Android oficial. API REST |
| VM 4 — KS-Client | Cliente Ubuntu para administración y conexiones SSH |
| VM 5/6 — KS-Dashboard | Portal web centralizado con alta disponibilidad (MASTER + BACKUP) |

---

## Herramientas de software

- **Proxmox VE 8.x:** Hipervisor de tipo 1 basado en Debian 12 y KVM. Permite la gestión de VMs y contenedores LXC mediante interfaz web (Licencia AGPL).
- **Ubuntu Server 24.04:** Sistema operativo base de las máquinas virtuales donde se instalan los servicios de Gotify y Uptime Kuma.
- **AlmaLinux 9:** Sistema operativo recomendado para desplegar Pandora FMS.
- **Uptime Kuma 1.x:** Aplicación de monitorización de tiempo de actividad desplegada en Docker. Soporta HTTP/S, TCP, ping, DNS y SNMP (Licencia MIT).
- **Docker Engine:** Plataforma de contenedores utilizada para el despliegue de Uptime Kuma y Gotify.
- **Pandora FMS Community Edition:** Plataforma de monitorización empresarial en versión comunitaria gratuita. Supervisa CPU, RAM, disco y red mediante agentes (Licencia GPL).
- **MySQL / MariaDB:** Base de datos utilizada por Pandora FMS para almacenar métricas y configuración.
- **Gotify:** Servidor de notificaciones push autoalojado con API REST y aplicación oficial para Android (Licencia MIT).
- **ntfy:** Sistema de notificaciones HTTP autoalojado.
- **KeePassXC:** Gestor de contraseñas cifrado para la centralización de credenciales de acceso.
- **Otras herramientas:** Git para control de versiones, cURL/wget para pruebas de conectividad y nano/vim como editores de texto.

---

## Herramientas de hardware

El servidor físico es el elemento central de la infraestructura. Fue donado por una de las empresas donde los autores realizan el módulo de Formación en Centros de Trabajo (FCT).

| Componente de hardware | Detalle / Configuración |
| :--- | :--- |
| Procesador (CPU) | Arquitectura x86-64 con soporte de virtualización (Intel VT-x / AMD-V) |
| Memoria RAM | Capacidad suficiente para alojar Proxmox VE y las máquinas virtuales simultáneas |
| Almacenamiento | Disco duro o SSD local. Proxmox gestiona el pool (LVM o ZFS) |
| Interfaz de red | Tarjeta Ethernet integrada. Proxmox crea un bridge virtual (vmbr0) para la LAN |
| Conexión a la red | El servidor se conecta a la LAN del centro, permitiendo acceso remoto a la interfaz web |

---

## Despliegue rápido

**Requisitos previos:**
- Proxmox VE 8.x instalado y accesible
- Máquinas virtuales con Ubuntu Server 24.04 o AlmaLinux 9
- Acceso root a las VMs

**1. Uptime Kuma** (Ubuntu Server 24.04)
```bash
sudo bash scripts/install_uptime_kuma.sh
# Interfaz disponible en http://<IP_VM>:3001
```

**2. Pandora FMS** (AlmaLinux 9 / EL9)
```bash
sudo bash scripts/install_pandora.sh
# Interfaz disponible en http://<IP_VM>/pandora_console
```

**3. Gotify** (Ubuntu Server 24.04)
```bash
sudo bash scripts/install_gotify.sh
# Interfaz disponible en http://<IP_VM>:8080
# Credenciales por defecto: usuario 'admin', contraseña 'admin'
```

**4. KS-Dashboard**
```bash
sudo bash ks-dashboard/install.sh
# El dashboard queda disponible en http://10.2.1.165
```

---

## Scripts de instalación

### install_uptime_kuma.sh

```bash
#!/bin/bash
# Instalación de Docker + Uptime Kuma
# Compatible con Ubuntu Server 24.04
# Ejecutar con privilegios de superusuario (root)

set -e

# 1. Instalar dependencias del sistema
apt-get update -y
apt-get install -y ca-certificates curl gnupg

# 2. Configurar el repositorio oficial de Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o \
  /etc/apt/keyrings/docker.gpg
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
docker run -d \
  --restart=always \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  --name uptime-kuma \
  louislam/uptime-kuma:1

echo ""
echo "Instalación completada con éxito."
echo "Accede a la interfaz web en: http://$(hostname -I | awk '{print $1}'):3001"
```

### install_pandora.sh

```bash
#!/bin/bash
# Instalación de Pandora FMS - Entorno Monolítico (EL9)
# Doc oficial: https://pandorafms.com/manual/!current/es/documentation/pandorafms/installation/01_installing
# Ejecutar como root en EL9 (RHEL 9 / Rocky Linux 9 / AlmaLinux 9)

curl -SsL https://pfms.me/deployenterprise | \
  TZ='Europe/Madrid' \
  DBHOST='127.0.0.1' \
  DBNAME='pandora' \
  DBUSER='pandora' \
  DBPASS='tucontraseñasegura99abc!' \
  DBPORT='3306' \
  DBROOTPASS='tucontraseñasegura99abc!' \
  MYVER=80 \
  PHPVER=8 \
  SKIP_PRECHECK=0 \
  SKIP_DATABASE_INSTALL=0 \
  SKIP_KERNEL_OPTIMIZATIONS=0 \
  PANDORA_AGENT_PACKAGE="https://firefly.pandorafms.com/pandorafms/latest/pandorafms_one_agent_linux_bin-latest.el9.x86_64.rpm" \
  PANDORA_BETA=0 \
  PANDORA_LTS=1 \
  PANDORA_ENT_FREE=1 \
  bash
```

### install_gotify.sh

```bash
#!/bin/bash
# Instalación de Docker + Gotify
# Compatible con Ubuntu Server 24.04
# Ejecutar con privilegios de superusuario (root)

set -e

# 1. Instalar dependencias del sistema
apt-get update -y
apt-get install -y ca-certificates curl gnupg

# 2. Configurar el repositorio oficial de Docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o \
  /etc/apt/keyrings/docker.gpg
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

# 5. Desplegar contenedor de Gotify
docker run -d \
  --restart=always \
  -p 8080:80 \
  -v gotify-data:/app/data \
  --name gotify \
  gotify/server

echo ""
echo "Instalación completada con éxito."
echo "Accede a la interfaz web en: http://$(hostname -I | awk '{print $1}'):8080"
echo "Credenciales por defecto: usuario 'admin', contraseña 'admin'"
```

---

## Administración

El sistema se gestiona a través de interfaces web independientes:

| Herramienta | Acceso |
| :--- | :--- |
| Proxmox VE | `http://10.2.1.253:8006` |
| Uptime Kuma | `http://10.2.1.168:3001` |
| Pandora FMS | `http://10.2.1.167/pandora_console` |
| Gotify | `http://10.2.1.169:8080` |
| ntfy | `http://10.2.1.169:8081` |
| KS-Dashboard | `http://10.2.1.165` |

Se han definido perfiles de usuario `root`/`admin` para acceso total y perfiles de monitorización/operador para tareas de solo lectura, garantizando la seguridad y trazabilidad.

---

## KS-Dashboard

Portal web centralizado que unifica el acceso a todas las herramientas de monitorización bajo una única interfaz. Desarrollado en HTML y CSS, servido mediante nginx.

Para garantizar la alta disponibilidad, se despliegan dos nodos nginx con **Keepalived** (protocolo VRRP):

- **MASTER** (`10.2.1.165`) y **BACKUP** (`10.2.1.164`) comparten una IP virtual (VIP).
- Si el MASTER cae, el BACKUP adquiere la IP automáticamente en menos de 3 segundos, de forma transparente para el usuario.
- La sincronización de contenido entre nodos se realiza con **lsyncd** + rsync sobre SSH.
- Las reglas de firewall permiten el protocolo VRRP exclusivamente entre los dos nodos, con autenticación por contraseña compartida.

---

## Seguridad

- Acceso a las consolas web restringido exclusivamente a la LAN del centro; ningún puerto es accesible desde Internet.
- Contraseñas con un mínimo de 12 caracteres en todos los servicios.
- Cada servicio corre en una VM independiente para contener posibles fallos.
- Las herramientas incluyen protección nativa contra fuerza bruta y vulnerabilidades web (XSS, inyección SQL).
- Copias de seguridad periódicas mediante cron jobs: snapshots de Proxmox, volcados de base de datos MySQL (Pandora FMS) y copias de directorios de datos (Uptime Kuma y Gotify).
- Sistema operativo y contenedores Docker actualizados regularmente.
- Credenciales centralizadas y cifradas con **KeePassXC**; las conexiones SSH al resto de la infraestructura se gestionan desde la VM de administración (KS-Client).

---

## Estructura del repositorio

```
/
├── README.md
├── LICENSE
├── /scripts
│   ├── install_gotify.sh
│   ├── install_ntfy.sh
│   ├── install_uptime_kuma.sh
│   └── pandorafms_install.sh
├── /ks-dashboard
│   └── index.html
└── /docs
    ├── Memoria projecte kevin y sergi.odt
    └── Memoria projecte kevin y sergio.pdf
```

---

## Documentación

La memoria técnica completa, los esquemas de red y los diagramas de arquitectura se encuentran en la carpeta [`/docs`](./docs).

---

## Licencia

Este proyecto se distribuye bajo licencia MIT. Consulta el fichero [`LICENSE`](./LICENSE) para más información.
