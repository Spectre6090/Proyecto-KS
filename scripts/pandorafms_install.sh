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
