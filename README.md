# Sistemas de Monitorización - IES Enric Soler i Godes

[cite_start]Este proyecto consiste en el diseño y despliegue de una infraestructura de monitorización completa sobre un entorno virtualizado, utilizando herramientas de código abierto para garantizar la disponibilidad y el rendimiento de servicios informáticos[cite: 4, 5, 20].

## 👤 Autores
* [cite_start]**Kevin Murciano Gadea** [cite: 6]
* [cite_start]**Sergio Ferrá Boix** [cite: 6]
* [cite_start]**Curso:** 2025-2026 [cite: 3]

## 🚀 Descripción del Proyecto
[cite_start]El objetivo principal es transformar una gestión reactiva de incidencias en un modelo proactivo[cite: 40, 56]. [cite_start]La solución se basa en un servidor físico con **Proxmox VE** que gestiona diversas máquinas virtuales dedicadas a la supervisión y alertas[cite: 47, 114].

## 🛠️ Stack Tecnológico
[cite_start]El proyecto utiliza exclusivamente software de código abierto[cite: 133]:

| Componente | Herramienta | Función |
| :--- | :--- | :--- |
| **Hipervisor** | Proxmox VE 8.x | [cite_start]Virtualización de tipo 1 [cite: 134, 135] |
| **Monitorización Web** | Uptime Kuma | [cite_start]Disponibilidad de servicios (HTTP/S, TCP, DNS) [cite: 127, 138] |
| **Monitorización Avanzada** | Pandora FMS | [cite_start]Rendimiento de hardware (CPU, RAM, Red) [cite: 129, 141] |
| **Notificaciones** | Gotify | [cite_start]Servidor de alertas push autoalojado [cite: 131, 144] |
| **Contenedores** | Docker Engine | [cite_start]Despliegue de servicios como Uptime Kuma [cite: 138, 140] |

## 🏗️ Arquitectura
[cite_start]El sistema se divide en tres capas principales[cite: 111]:
1. [cite_start]**Hardware:** Servidor físico x86-64 con soporte para virtualización[cite: 152].
2. [cite_start]**Virtualización:** Proxmox VE gestionando 3 máquinas virtuales independientes[cite: 115, 116].
3. [cite_start]**Servicios:** Comunicación mediante APIs (REST) para el envío de alertas desde los monitores hacia Gotify[cite: 117, 131].

## 🔐 Seguridad
* [cite_start]**Aislamiento:** Cada servicio se ejecuta en su propia VM[cite: 238].
* [cite_start]**Acceso:** Restringido a la red LAN local; sin exposición a Internet[cite: 236, 237].
* [cite_start]**Backup:** Copias de seguridad automáticas de configuraciones y bases de datos MySQL[cite: 241].

## 📂 Estructura del Repositorio
* [cite_start]`/scripts`: Contiene los scripts de instalación automatizada (`.sh`) para Uptime Kuma y Pandora FMS[cite: 170, 171, 204].
* `/docs`: Memoria del proyecto y esquemas de red.
