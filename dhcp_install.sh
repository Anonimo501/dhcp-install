#!/bin/bash

echo "													   "
echo "	 												   "
echo "	 ▓█████▄  ██░ ██  ▄████▄   ██▓███      ██▓ ███▄    █   ██████ ▄▄▄█████▓ ▄▄▄       ██▓     ██▓      "
echo "	 ▒██▀ ██▌▓██░ ██▒▒██▀ ▀█  ▓██░  ██▒   ▓██▒ ██ ▀█   █ ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██▒    ▓██▒      "
echo "	 ░██   █▌▒██▀▀██░▒▓█    ▄ ▓██░ ██▓▒   ▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░    ▒██░      "
echo "	 ░▓█▄   ▌░▓█ ░██ ▒▓▓▄ ▄██▒▒██▄█▓▒ ▒   ░██░▓██▒  ▐▌██▒  ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██░    ▒██░      "
echo "	 ░▒████▓ ░▓█▒░██▓▒ ▓███▀ ░▒██▒ ░  ░   ░██░▒██░   ▓██░▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██████▒░██████▒  "
echo "	  ▒▒▓  ▒  ▒ ░░▒░▒░ ░▒ ▒  ░▒▓▒░ ░  ░   ░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒░▓  ░░ ▒░▓  ░  "
echo "	  ░ ▒  ▒  ▒ ░▒░ ░  ░  ▒   ░▒ ░         ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░    ░      ▒   ▒▒ ░░ ░ ▒  ░░ ░ ▒  ░  "
echo "	  ░ ░  ░  ░  ░░ ░░        ░░           ▒ ░   ░   ░ ░ ░  ░  ░    ░        ░   ▒     ░ ░     ░ ░     "
echo "	    ░     ░  ░  ░░ ░                   ░           ░       ░                 ░  ░    ░  ░    ░  ░  "
echo "	  ░              ░                                                                                 "
echo "													   "
echo "	 												   "
echo "					[Created By Anonimo501] 					   "
echo "				  [https://youtube.com/c/Anonimo501]					   "
echo "													   "
echo "				    Hola bienvenid@s a DHCP Install		                           "
echo "					      Version 1.0						   "
echo " 													   "
echo " "
echo " "
read -rsp $'Press enter to continue...\n'

echo "**************************************"
echo " iniciaremos la instalacion de DHCP "
echo "**************************************"
#Se instalara dhcp
yum install dhcp -y
echo " "
echo "********************************************************************************"
echo " Se Anadira la interface ens34 al archivo dhcpd en la ruta /etc/sysconfig/dhcpd "
echo "********************************************************************************"
echo " "
read -rsp $'Press enter to continue...\n'
#se añade DHCPDARGS=ens34 al final del archivo dhcpd
echo "DHCPDARGS=ens34" >> /etc/sysconfig/dhcpd
echo " "
echo "*************************************************************************************************"
echo " A continuacion se configurara el archivo dhcp.conf en la ruta /etc/dhcp/dhcp.conf lo siguiente: "
echo " la ip de red 192.168.1.0  "
echo " con un rango de 100 ips de la 192.168.1.100 a la 192.168.1.200 "
echo " la ip del servidor sera la 192.168.1.1 "
echo " ip de gateway 192.168.1.1 y su broadcast sera 192.168.1.255  "
echo "*************************************************************************************************"
echo " "
read -rsp $'Press enter to continue...\n'

echo "
authoritative;

# A slightly different configuration for an internal subnet.
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option domain-name-servers 192.168.1.10;
 #option domain-name "Anonimo501.net";
  option routers 192.168.1.1;
  option broadcast-address 192.168.1.255;
  default-lease-time 600;
  max-lease-time 14400;
}

# host soporte-pc podemos descomentarlo y añadir un pc cliente
# de forma estatica para ello necesitamos su IP y su MAC

#host soporte-PC {
#  hardware ethernet 08:00:27:34:F2:68;
#  fixed-address 192.168.1.5;
#} 

" >> /etc/dhcp/dhcpd.conf
echo " "
echo "******************************************"
echo " Se bajara y se subira la interface ens34 "
echo "******************************************"
echo " "
read -rsp $'Press enter to continue...\n'
# se baja y se sube la interface de red ens34
ifdown ens34
ifup ens34

echo " "
echo "****************************"
echo " habilitaremos el firewall  "
echo "****************************"
echo " "
read -rsp $'Press enter to continue...\n'
# Se habilita el firewall para el servidio dhcp
firewall-cmd  --permanent --add-service=dhcp
firewall-cmd --reload

echo " "
echo "**********************************************************************************"
echo " Ahora iniciaremos el servicio DHCP y de dejara para que arranque con el sistema  "
echo "**********************************************************************************"
echo " "
read -rsp $'Press enter to continue...\n'
# Iniciamos el servicio dhcp y luego lo dejamos habilitado
# para que inicie al inicio de la maquina
systemctl start dhcpd
systemctl enable dhcpd

echo " "
echo "*********************************************************************"
echo " MUY BIEN! ya tienes instalado DHCP en tu Maquina hasta la proxima.  "
echo "*********************************************************************"
echo " "
read -rsp $'Press enter to Finish...\n'
