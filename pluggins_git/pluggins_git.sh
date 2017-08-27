#!/bin/bash
# Author: Marcelo Rusconi
#

DIRECTORIO=$(pwd)
USUARIO=$(whoami)

function_test() {
	if [ ! -e /etc ]
	then
	  echo "el file NO exsiste"
	else
	  echo "el file SI exsiste"
	  
	fi
}

function_git_plugins_color_branch() {
	echo 'Agregando las configuraciones para colorear las indicaciones de GIT'
	if [ -e /etc/gitconfig ]
	then
		sudo cat $DIRECTORIO/files/git_plugins_color_branch/gitconfig >> /etc/gitconfig
	else
		sudo cp $DIRECTORIO/files/git_plugins_color_branch/gitconfig /etc/gitconfig
	fi
	wait 
	sleep 2
	echo 'Agregando las configuraciones para los branches de GIT'
	sudo cat $DIRECTORIO/files/git_plugins_color_branch/bashrc >> /home/intranet.biblostravel.com/$USUARIO/.bashrc
	wait 
	sleep 2
	echo "Proceso finalizado, reinicie la terminal"
}

function_git_diff_meld() {
	echo 'Instalando Meld'
	sudo apt-get install meld
	wait
	sleep 1
	echo 'Configurando meld para diff de Git'
	sudo cp $DIRECTORIO/files/diff_meld/diff.py /home/$USUARIO/
	sudo chmod 777 /home/$USUARIO/diff.py
	git config --global diff.external /home/$USUARIO/diff.py
	wait
	sleep 1
	echo 'Configurar herramienta de comparacion -difftool-'
	git config --global diff.tool meld
	wait
	sleep 1
	echo 'Configurar herramienta de fusion -mergetool-'
	git config --global merge.tool meld
	wait
	sleep 1
	echo "Proceso finalizado, reinicie la terminal"
}

while [ "$opcion" != 0,2 ]
do
	echo " Seleccionar funcion "
	echo "0 - TEST"
	echo "1 - PLUGINS PARA GIT(COLORES Y NOMBRE DE BRANCH)"
	echo "2 - USAR MELD PARA DIFF EN GIT"
	read -p "Seleccione una opcion: " opcion
	case $opcion in
		0)
		   function_test
		   exit 0;
		   ;;
		1)
		   function_git_plugins_color_branch
		   exit 0;
		   ;;
		2)
		   function_git_diff_meld
		   exit 0;
		   ;;
		*) echo "$opcion es una opcion invalida.";
		   ;;
	esac
done
