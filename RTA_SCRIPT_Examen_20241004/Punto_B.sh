#!/bin/bash
#Particionamiento en 10 partes del disco.
sudo fdisk /dev/sdb <<EOF
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

#Da  formato Ext4 a las particiones, evitando sdb4, particion extendida.
for i in {1..11}; do
  if [ $i -ne 4 ]; then
     sudo mkfs -t ext4 /dev/sdb$i
  fi
done

#Genera los mount en los respectivos directorios y genera el montaje de forma permanente, evitando a su vez el sdb4, particion extendida.
alumno=1
parcial=1

for i in {1..11}; do
    if [ $i -eq 11 ]; then
        sudo mount /dev/sdb$i /Examenes-UTN/profesores
        echo "/dev/sdb$i /Examenes-UTN/profesores ext4 defaults 0 0" | sudo tee -a /etc/fstab
    fi

    if [ $i -ne 4 ] && [ $i -ne 11 ]; then
        sudo mount /dev/sdb$i /Examenes-UTN/alumno_$alumno/parcial_$parcial
        echo "/dev/sdb$i /Examenes-UTN/alumno_$alumno/parcial_$parcial ext4 defaults 0 0" | sudo tee -a /etc/fstab
        parcial=$((parcial + 1))

        if [ $parcial -eq 4 ]; then
            parcial=1
            alumno=$((alumno + 1))
        fi
    fi

done

sudo mount -a
