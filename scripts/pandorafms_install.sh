#!/bin/bash
# Instalación de Pandora FMS - Entorno Monolítico (EL9)
# Doc oficial: https://pandorafms.com/manual/!current/es/documentation/pandorafms/installation/01_installing
# Ejecutar como root en EL9 (RHEL 9 / Rocky Linux 9 / AlmaLinux 9)
env TZ='Europe/Madrid' \
 DBHOST='127.0.0.1' \
 DBNAME='pandora' \
 DBUSER='pandora' \
 DBPASS='wjI4XT9WahZFfioyioYsqukx_' \
 DBPORT='3306' \
 DBROOTPASS='wjI4XT9WahZFfioyioYsqukx_' \
 MYVER=80 \
 PHPVER=8.2 \
 SKIP_PRECHECK=0 \
 SKIP_DATABASE_INSTALL=0 \
 SKIP_KERNEL_OPTIMIZATIONS=0 \
 PANDORA_LTS=1 \
 PANDORA_ENT_FREE=1 \
 bash -c "$(curl -SsL https://pfms.me/deployenterprise)"



