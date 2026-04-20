# Sistemas de Monitorización - IES Enric Soler i Godes

[cite_start]Este proyecto consiste en el diseño y despliegue de una infraestructura de monitorización completa sobre un entorno virtualizado, utilizando herramientas de código abierto para garantizar la disponibilidad y el rendimiento de servicios informáticos[cite: 4, 5, 20].

## 👤 Autores
* [cite_start]**Kevin Murciano Gadea** [cite: 6]
* [cite_start]**Sergio Ferrá Boix** [cite: 6]
* **NIA:** 10788620 | [cite_start]10663813 [cite: 7]
* [cite_start]**Curso:** 2025-2026 [cite: 3]

---

## 🚀 Descripción del Proyecto
[cite_start]El objetivo principal es transformar una gestión reactiva de incidencias en un modelo proactivo[cite: 40, 56]. [cite_start]La solución se basa en un servidor físico con **Proxmox VE** que gestiona diversas máquinas virtuales independientes dedicadas a la supervisión y alertas[cite: 47, 114].

## 🛠️ Stack Tecnológico
[cite_start]El proyecto utiliza exclusivamente software de código abierto para eliminar costes de licencias[cite: 133].

| Componente | Herramienta | Función |
| :--- | :--- | :--- |
| **Hipervisor** | Proxmox VE 8.x | [cite_start]Virtualización de tipo 1 basada en KVM[cite: 134, 135]. |
| **Monitorización Web** | Uptime Kuma | [cite_start]Disponibilidad de servicios y endpoints (HTTP/S, TCP, DNS)[cite: 127, 138]. |
| **Monitorización Avanzada** | Pandora FMS | [cite_start]Rendimiento de hardware: CPU, RAM, Red y Disco[cite: 129, 141]. |
| **Notificaciones** | Gotify | [cite_start]Servidor de alertas push autoalojado con API REST[cite: 131, 144]. |
| **Contenedores** | Docker Engine | [cite_start]Base para el despliegue de Uptime Kuma[cite: 138, 140]. |

---

## 🏗️ Arquitectura del Sistema
[cite_start]El sistema se estructura en tres capas principales[cite: 111]:

* [cite_start]**Hardware:** Servidor físico x86-64 con soporte para virtualización (Intel VT-x / AMD-V)[cite: 152].
* [cite_start]**Virtualización:** Capa gestionada por Proxmox VE que aloja 3 máquinas virtuales independientes[cite: 114, 115, 116].
* [cite_start]**Servicios:** Comunicación integrada donde Uptime Kuma y Pandora FMS envían alertas a Gotify para notificaciones en tiempo real[cite: 117, 118].

## 🔐 Seguridad
[cite_start]Para garantizar la integridad del sistema, se han implementado las siguientes medidas[cite: 235]:
* [cite_start]**Aislamiento:** Cada servicio corre en una VM independiente para contener fallos[cite: 238].
* [cite_start]**Acceso Restringido:** Consolas web accesibles únicamente desde la LAN del centro; sin exposición a Internet[cite: 236, 237].
* [cite_start]**Recuperación:** Copias de seguridad periódicas (snapshots de Proxmox y volcados de MySQL)[cite: 241].

## 📂 Estructura del Repositorio
* [cite_start]**`/scripts`**: Contiene los scripts automatizados en Bash para la instalación de los servicios[cite: 170, 171, 204].
* **`/docs`**: Documentación técnica, memoria del proyecto y esquemas de red.
