#!/bin/bash
#Particionamiento en 10 partes del disco.
lsblk
read -p "Ingrese la letra de su disco a particionar, formatear y montar: " disco
if [ "$disco" == "a" ]; then
  echo "ERROR. No puede particionar este disco!"
  exit 1

fi
if [ ! -d "/Examenes-UTN" ]; then 
  echo "ERROR. Primero debe crear el directorio Examenes-UTN. Ejecute script Punto_A!"
  exit 1

fi
if ! lsblk | grep -q "^sd$disco"; then
  echo "ERROR. El disco /dev/sd$disco no existe."
  exit 1
fi
sudo fdisk /dev/sd$disco <<EOF
n
p


+1G
n
p


+1G
n
p


+1G
n
e



n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n


w
EOF

for i in {1..11}; do
  if [ $i -ne 4 ]; then
     sudo mkfs -t ext4 /dev/sd${disco}${i}
  fi
done


alumno=1
parcial=1

for i in {1..11}; do
    if [ $i -eq 11 ]; then
        sudo mount /dev/sd${disco}${i} /Examenes-UTN/profesores
        echo "/dev/sd${disco}${i} /Examenes-UTN/profesores ext4 defaults 0 0" | sudo tee -a /etc/fstab
    fi

    if [ $i -ne 4 ] && [ $i -ne 11 ]; then
        sudo mount /dev/sd${disco}${i} /Examenes-UTN/alumno_$alumno/parcial_$parcial
        echo "/dev/sdb${disco}${i} /Examenes-UTN/alumno_$alumno/parcial_$parcial ext4 defaults 0 0" | sudo tee -a /etc/fstab
        parcial=$((parcial + 1))

        if [ $parcial -eq 4 ]; then
            parcial=1
            alumno=$((alumno + 1))
        fi
    fi

done

sudo mount -a

echo "Particiones:"
lsblk | grep sd$disco
echo "Puntos de montaje:"
cat /etc/fstab | grep "sd"
echo "Particion, formateo y montaje exitoso!"
