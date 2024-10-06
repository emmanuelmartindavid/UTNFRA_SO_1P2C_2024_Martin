#!/bin/bash
#Genera filtro_avanzado con los datos solicitados.
echo "Mi IP Publica es: $(curl -s ifconfig.me)" > /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_avanzado.txt
echo "Mi usuarioes: $(whoami)" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_avanzado.txt
echo "El hash de mi Usuario es: $(sudo grep osboxes /etc/shadow | awk -F ':' '{print $2}')" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_avanzado.txt
cd /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin
echo "La url de mi repositorio es: $(git remote get-url origin)" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_Martin/RTA_ARCHIVOS_Examen_20241004/filtro_avanzado.txt
cd

