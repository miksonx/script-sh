#!/bin/bash

sudo apt-get update

#Function for checking if theres any nodeJS pre-installed on your system
function node_version(){
	if which node > /dev/null
	    then
	    echo "------------------------------------------------------------------------------"
	    echo "node" $(node -v) "is already installed on this machine"
		echo "Do you want to uninstall, reinstall node? or install only pm2 process manager"
		echo "------------------------------------------------------------------------------"
	   	OPTIONS="Uninstall reinstall PM2 Exit"
		select opt in $OPTIONS; do
	    if [ "$opt" = "Uninstall" ]; then
		    node_uninstall
		    exit
		elif [ "$opt" = "reinstall" ]; then
			node_uninstall
			node_install
		exit
	    elif [ "$opt" = "PM2" ]; then
	    	sudo npm install pm2 -g
	    exit
	    elif [ "$opt" = "Exit" ]; then
	    	echo "---------------------------"
	    	echo "Ok than, have a nice day!"
	    	echo "---------------------------"
	    exit
		else
			echo "---------------------------------------"
		    echo "bad option please select 1, 2, 3 or 4"
		    echo "---------------------------------------"
		fi
	done
	else
		node_install
	fi
}

#node uninstall function
function node_uninstall(){
	echo "---------------------------"
	echo "Commencing uninstall node"
	echo "---------------------------"
	sudo pm2 kill
	sudo npm remove pm2 -g
	sudo apt-get -y purge nodejs
	sudo apt-get -y purge --auto-remove nodejs
	echo "-------------------------------"
	echo "Node succsesfully uninstalled"
	echo "-------------------------------"
}

#Function for installing nodeJS
function node_install(){
	echo "---------------------------------------------"
	echo "Commencing nodejs install"
	echo "which version would you like to be installed"
	echo "---------------------------------------------"
	OPTIONS="8.x-LTS 9.x"
	select opt in $OPTIONS; do
	    if [ "$opt" = "8.x-LTS" ]; then
			sudo apt-get install python-software-properties
			curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
			sudo apt-get install nodejs
			echo "-----------------------------------------------------"
			echo "You have succsesfully install node version " $(node -v)
			echo "You have succsesfully install npm version " $(node -v)
			echo "-----------------------------------------------------"
			pm2
		exit
	    elif [ "$opt" = "9.x" ]; then
			sudo apt-get install python-software-properties
			curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
			sudo apt-get install nodejs
			echo "-----------------------------------------------------"
			echo "You have succsesfully install node version " $(node -v)
			echo "You have succsesfully install npm version " $(node -v)
			echo "-----------------------------------------------------"
			pm2
		exit	
		else
			echo "-----------------------------------------------"
		    echo "bad option choose 1 or 2 for the right version"
		    echo "-----------------------------------------------"
		fi
	done	
}

#PM2 process manager for nodejs installation
function pm2(){
echo "-------------------------------------------------------------------------"	
echo "Alternative: - Would you like to install PM2 process manager for NodeJS?"
echo "-------------------------------------------------------------------------"
OPTIONS="Yes No"
	select opt in $OPTIONS; do
	    if [ "$opt" = "Yes" ]; then
			sudo npm install pm2 -g
			echo "---------------------------"
			echo "PM2 succsesfully installed"
			echo "---------------------------"
		exit
	    elif [ "$opt" = "No" ]; then
	    	echo "---------------------------"
			echo "Ok than, have a nice day!"
			echo "---------------------------"
		exit	    
		fi
	done
}

node_version
