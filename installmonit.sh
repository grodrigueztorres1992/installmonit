#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   installmonit.sh 
# Description:   Implementar instalacion de monit
# Written by:    Guillermo Rodriguez
# Maintenance:   Guillermo Rodriguez
# ------------------------------------------------------------------------ #
# Usage:         
#       $ ./install.sh


function menuprincipal () {
clear
TIME=1
echo "
######
#     #  #####    ####   #####   ######  #####   ######   ####
#     #  #    #  #    #  #    #  #       #    #  #       #
######   #    #  #    #  #    #  #####   #    #  #####    ####
#        #####   #    #  #####   #       #    #  #            #
#        #   #   #    #  #   #   #       #    #  #       #    #
#        #    #   ####   #    #  ######  #####   ######   #### 

by:grodriguez@proredes.net"
echo $0
echo " "
echo "Ingresa la opcion correspondiente!

        1 - Saber que sistema es.
        2 - Instalar monit en CentOs 7
        3 - Instalar monit en CentOs 5
        4 - Agregar SNMP a monit (Centos)
        5 - Agregar ASTERISK a monit (Centos)
        6 - Agregar MYSQL a monit (Centos)
	0 - Salir"
echo " "
echo -n "Ingresa option: "
read opcion
case $opcion in

    1)
		function kernel () {
			#RED HAT: cat /etc/redhat-release
			KERNEL_VERSION_UBUNTU=`uname -r`
			KERNEL_VERSION_CENTOS=`uname -r`
			if [ -f /etc/lsb-release ]
			then
				echo "kernel version: $KERNEL_VERSION_UBUNTU"
			else
				echo "kernel version: $KERNEL_VERSION_CENTOS"
			fi
		}
		kernel
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;

	2)
		function INSTALLCENTOS7 () {
			Install=`yum install monit -y`
			EnableMonit=`systemctl enable --now monit`
            CREADIR=`mkdir -p /etc/monit/conf-enabled`
            PERMISOS=`chmod 777 -R /etc/monit/conf-enabled`
            INCLUDE=`echo "include /etc/monit/conf-enabled/*" >> /etc/monitrc`
			RESTART=`systemctl restart monit`
            echo $Install
			echo $EnableMonit
            echo $CREADIR
            echo $PERMISOS
            echo $INCLUDE
            echo $RESTART
		}
		INSTALLCENTOS7
		echo "Se realiza instalacion de monit debes configurar!"
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;

	3)
		function INSTALLCENTOS5 () {
			Install=`yum install monit -y`
			EnableMonit=`chkconfig monit on`
            CREADIR=`mkdir -p /etc/monit/conf-enabled`
            PERMISOS=`chmod 777 -R /etc/monit/conf-enabled`
            INCLUDE=`echo "include /etc/monit/conf-enabled/*" >> /etc/monitrc`
			RESTART=`service monit restart`
            echo $Install
			echo $EnableMonit
            echo $CREADIR
            echo $PERMISOS
            echo $INCLUDE
            echo $RESTART
												
		}
		INSTALLCENTOS5
		echo "Se realiza instalacion de monit debes configurar!"
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;
    4)
		function SNMP () {
			Crear=`touch /etc/monit/conf-enabled/snmp`
			PERMISOS=`chmod 777 /etc/monit/conf-enabled/snmp`
            PIDSNMP=`ps aux | pgrep snmp > /run/snmpd.pid`
            Conf=`echo '# SNMP configuration 
            check process snmpd with pidfile /run/snmpd.pid
    start program = "/bin/systemctl start snmpd" with timeout 60 seconds
    stop program  = "/bin/systemctl stop snmpd"' > /etc/monit/conf-enabled/snmp`
			RESTART=`monit reload`
            echo $Crear
			echo $PERMISOS
            echo $PIDSNMP
            echo $Conf
            echo $RESTART
												
		}
		SNMP
		echo "Se ha configurado SNMP en monit!"
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;

    5)
		function ASTERISK () {
			Crear=`touch /etc/monit/conf-enabled/asterisk`
			PERMISOS=`chmod 777 /etc/monit/conf-enabled/asterisk`
            Conf=`echo '# ASTERISK configuration 
            check process asterisk with pidfile /run/asterisk/asterisk.pid
            start program = "/bin/systemctl start asterisk" with timeout 60 seconds
            stop program  = "/bin/systemctl stop asterisk"' > /etc/monit/conf-enabled/asterisk`
			RESTART=`monit reload`
            echo $Crear
			echo $PERMISOS
            echo $Conf
            echo $RESTART
												
		}
		ASTERISK
		echo "Se ha configurado ASTERISK en monit!"
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;

    6)
		function MYSQL () {
			Crear=`touch /etc/monit/conf-enabled/mysql`
			PERMISOS=`chmod 777 /etc/monit/conf-enabled/mysql`
            Conf=`echo '# MYSQL configuration 
            check process asterisk with pidfile /run/mariadb/mariadb.pid
            start program = "/bin/systemctl start mysqld" with timeout 60 seconds
            stop program  = "/bin/systemctl stop mysqld"' > /etc/monit/conf-enabled/mysql`
			RESTART=`monit reload`
            echo $Crear
			echo $PERMISOS
            echo $Conf
            echo $RESTART
												
		}
		MYSQL
		echo "Se ha configurado MYSQL en monit!"
		read -n 1 -p "<Enter> volver al Menu Principal"
		menuprincipal
		;;
	0) 
	       echo Saliendo de la instalacion
       	       sleep $TIME
	       exit 0
	       ;;

	*)
		echo Opcion Invalida, Vuelve a intentarlo!
		;;
esac
}
menuprincipal
