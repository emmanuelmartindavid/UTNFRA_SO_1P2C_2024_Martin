#!/bin/bash
#Comandos para generar el filtro_basico con los datos de memoria y chassis solicitados.
sudo cat /proc/meminfo | head -1 > /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_basico.txt
sudo dmidecode -t chassis | head -7 | tail -2 >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_basico.txt

