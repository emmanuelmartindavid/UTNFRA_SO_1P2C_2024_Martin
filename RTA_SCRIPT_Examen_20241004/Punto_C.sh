#!/bin/bash
#VaLida que se cree primero el directorio correspondiente antes de ejecutar los comandos correspondientes. 
if [ ! -d "/Examenes-UTN" ]; then
  echo "ERROR. Primero debe crear el directorio Examenes-UTN. Ejecute script Punto_A!"
  exit 1

fi
#Genera los usuarios con su respectivo grupo y agrega a su vez la contrasenia de en este caso osboxes.
sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

#Asigna la propiedad a cada usuario de su respectivo directorio y le da los permisos solicitados.
#Crea los archivos de texto validar.txt y agrega con el comando whoami el nombre respectivo de propietario en directorio correspondiente.
for i in {1..3}; do
  echo "i" $i
  sudo useradd -m -s /bin/bash -c "Alumno p1c2_2024_A$i" -G p1c2_2024_gAlumno -p "$(sudo grep osboxes /etc/shadow | awk -F ':' '{print $2}')" p1c2_2024_A$i
  sudo chown p1c2_2024_A$i:p1c2_2024_A$i /Examenes-UTN/alumno_$i
    if [ "$i" -eq 1 ]; then
    sudo chmod 750 /Examenes-UTN/alumno_1
    elif [ "$i" -eq 2 ]; then
    sudo chmod 760 /Examenes-UTN/alumno_2
    elif [ "$i" -eq 3 ]; then
    sudo chmod 700 /Examenes-UTN/alumno_3
    fi
    sudo su -c "whoami > /Examenes-UTN/alumno_$i/validar.txt" p1c2_2024_A$i

done
sudo useradd -m -s /bin/bash -c "Profesor p1c2_2024_P1" -G p1c2_2024_gProfesores -p "$(sudo grep osboxes /etc/shadow | awk -F ':' '{print $2}')" p1c2_2024_P1
sudo chown p1c2_2024_P1:p1c2_2024_gProfesores /Examenes-UTN/profesores
sudo chmod 775 /Examenes-UTN/profesores
sudo su -c "whoami > /Examenes-UTN/profesores/validar.txt" p1c2_2024_P1
