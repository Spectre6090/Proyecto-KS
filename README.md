# Sistemas de Monitorización — IES Enric Soler i Godes

![Proxmox](https://img.shields.io/badge/Proxmox_VE-E57000?style=flat&logo=proxmox&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![nginx](https://img.shields.io/badge/nginx-009639?style=flat&logo=nginx&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue)

Diseño y despliegue de una infraestructura de monitorización completa sobre un entorno virtualizado con Proxmox VE, utilizando exclusivamente herramientas de código abierto. El objetivo es transformar una gestión reactiva de incidencias en un modelo proactivo: detectar anomalías antes de que afecten al servicio.

---dashboard

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

Todo el software utilizado es de código abierto. No se ha adquirido ninguna licencia de pago.

---

## Arquitectura

El sistema se estructura en tres capas principales:

- **Hardware:** Servidor físico x86-64 donado por empresa de FCT.
- **Virtualización:** Proxmox VE gestiona tres máquinas virtuales independientes (Ubuntu Server 24.04 y AlmaLinux 9).
- **Servicios:** Uptime Kuma y Pandora FMS envían alertas a Gotify y ntfy, que distribuyen notificaciones push a los dispositivos de los administradores.

```
Servidor físico
└── Proxmox VE
    ├── VM 1 — Uptime Kuma     (10.2.1.168)
    ├── VM 2 — Pandora FMS     (10.2.1.167)
    └── VM 3 — Gotify + ntfy   (10.2.1.169)
    └── VM 4 — KS-Client       (10.2.1.165)
    └── VM 5 — KS-Dashboard    (10.2.1.166)

Portal web
└── KS-Dashboard (nginx)       (10.2.1.166)
    ├── → Pandora FMS
    ├── → Uptime Kuma
    ├── → Gotify
    └── → ntfy
```

---

## KS-Dashboard

Portal web centralizado que unifica el acceso a todas las herramientas de monitorización bajo una única interfaz con autenticación y gestión de usuarios.

![KS-Dashboard](docs/diagrams/ks-dashboard-screenshot.png)
*(screenshot)*

**Accesos configurados:**

| Herramienta | URL |
| :--- | :--- |
| Pandora FMS | `http://10.2.1.167/pandora_console` |
| Uptime Kuma | `http://10.2.1.168:3001` |
| Gotify | `http://10.2.1.169:8080` |
| ntfy | `http://10.2.1.169:8081` |

---

## Estructura del repositorio

```
/
├── README.md
├── .gitignore
├── /scripts
│   ├── README.md
│   ├── install_uptime_kuma.sh
│   ├── install_pandora.sh
│   └── install_ks_dashboard.sh
├── /ks-dashboard
│   ├── index.html
│   └── install.sh
└── /docs
    ├── memoria.pdf
    └── /diagrams
        └── arquitectura.png
```

---

## Despliegue rápido

**Requisitos previos:**
- Proxmox VE 8.x instalado y accesible
- Máquinas virtuales con Ubuntu Server 24.04 o AlmaLinux 9
- Acceso root a las VMs

**1. Uptime Kuma**
```bash
sudo bash scripts/install_uptime_kuma.sh
```

**2. KS-Dashboard**
```bash
sudo bash ks-dashboard/install.sh
# El dashboard queda disponible en http://10.2.1.170
```

---

## Seguridad

- Acceso a las consolas web restringido exclusivamente a la LAN del centro.
- Contraseñas con un mínimo de 12 caracteres en todos los servicios.
- Cada servicio corre en una VM independiente para contener posibles fallos.
- Copias de seguridad periódicas mediante cron jobs: snapshots de Proxmox y volcados de base de datos MySQL (Pandora FMS).
- Sistema operativo y contenedores Docker actualizados regularmente.

---

## Documentación

La memoria técnica completa, los esquemas de red y los diagramas de arquitectura se encuentran en la carpeta [`/docs`](./docs).

---

## Licencia

Este proyecto se distribuye bajo licencia MIT. Consulta el fichero [`LICENSE`](./LICENSE) para más información.
