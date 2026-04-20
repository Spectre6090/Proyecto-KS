# Sistemas de Monitorización - IES Enric Soler i Godes

Este proyecto consiste en el diseño y despliegue de una infraestructura de monitorización completa sobre un entorno virtualizado, utilizando herramientas de código abierto para garantizar la disponibilidad y el rendimiento de servicios informáticos.

## 👤 Autores
* **Kevin Murciano Gadea** (NIA: 10788620)
* **Sergio Ferrá Boix** (NIA: 10663813)
* **Curso:** 2025-2026

---

## 🚀 Descripción del Proyecto
El objetivo principal es transformar una gestión reactiva de incidencias en un modelo proactivo. En lugar de esperar a que el usuario reporte un fallo, el sistema monitoriza la red 24/7 para detectar anomalías antes de que afecten al servicio.

La solución se basa en un servidor físico con **Proxmox VE** que gestiona diversas máquinas virtuales independientes dedicadas a la supervisión, análisis de rendimiento y gestión de alertas.

## 🛠️ Stack Tecnológico
El proyecto utiliza exclusivamente software de código abierto (Open Source).

| Componente | Herramienta | Función |
| :--- | :--- | :--- |
| **Hipervisor** | Proxmox VE 8.x | Virtualización de tipo 1 (KVM/LXC). |
| **Monitorización Web** | Uptime Kuma | Disponibilidad de servicios (HTTP/S, TCP, DNS, Ping). |
| **Monitorización Avanzada** | Pandora FMS | Rendimiento de hardware: CPU, RAM, Red y Disco. |
| **Notificaciones** | Gotify / ntfy | Servidor de alertas push autoalojado con API REST. |
| **Contenedores** | Docker Engine | Base para el despliegue de microservicios. |

---

## 🏗️ Arquitectura del Sistema
El sistema se estructura en tres capas principales:

* **Hardware:** Servidor físico x86-64 donado por empresa de FCT.
* **Virtualización:** Entorno gestionado por Proxmox VE que aloja 3 máquinas virtuales (Ubuntu Server y AlmaLinux).
* **Servicios:** Flujo de alertas integrado donde los monitores envían datos a Gotify para notificaciones móviles inmediatas.

## 🔐 Seguridad y Mantenimiento
* **Aislamiento:** Cada servicio corre en una VM independiente para contener posibles fallos de seguridad.
* **Acceso LAN:** Las consolas web solo son accesibles desde la red interna del centro.
* **Backups:** Implementación de snapshots periódicos en Proxmox y volcados de bases de datos SQL para recuperación ante desastres.

## 📂 Estructura del Repositorio
* **`/scripts`**: Automatización en Bash para la instalación de Docker, Uptime Kuma y Pandora FMS.
* **`/docs`**: Memoria técnica detallada y esquemas de red del proyecto.
