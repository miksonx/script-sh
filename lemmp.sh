#!/bin/bash


function nginx(){
	function nginx_install(){

		# NGINX web server
		apt-get -y install nginx
		echo "---------------------------------------"
		echo "You have succsesfully installed nginx"
		echo "---------------------------------------"

	}

	function nginx_uninstall(){
		sudo apt-get remove nginx nginx-common -y
		sudo apt-get purge nginx nginx-common -y
		sudo apt-get autoremove -y
		echo "---------------------------------------"
		echo "You have succsesfully uninstalled nginx"
		echo "---------------------------------------"
	}

	function nginx_version(){
		if which nginx > /dev/null
	    then
	    	echo "--------------------------------------------"
		    echo "nginx is already installed on this machine"
		    sudo nginx -v
			echo "Do you want to reinstall nginx? "
			echo "--------------------------------------------"
		   	OPTIONS="Yes No Uninstall"
			select opt in $OPTIONS; do
		    if [ "$opt" = "Yes" ]; then
		   	    nginx_uninstall
			    nginx_install
			    exit
			elif [ "$opt" = "No" ]; then
				echo "---------------------------"
				echo "OK than, Have a nice day!"
				echo "---------------------------"
			exit	
			elif [ "$opt" = "Uninstall" ]; then
				nginx_uninstall
				exit
			else
				echo "--------------------------------"
			    echo "bad option please select 1 or 2"
			    echo "--------------------------------"
			fi
		done
		else
			nginx_install
	fi
	}

	nginx_version

}


function php7(){

	function php_install(){
		
		sudo add-apt-repository ppa:ondrej/php -y
		apt-get update && apt-get -y upgrade -y
		sudo apt-get install -y php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache \
							php7.2-mysql php7.2-mbstring php7.2-zip php7.2-fpm \
							php7.2-curl php7.2-gd php7.2-intl php7.2-xsl
		  	echo "----------------------------------------------"
		    echo "php is successfully installed on this machine"
		    php -r \@phpinfo\(\)\; | grep 'PHP Version' -m 1
			echo "----------------------------------------------"	
	}

	function php_uninstall(){

		#purge every php package
		sudo apt-get -y purge php.*
		
	}

	function php_version(){
		if which php > /dev/null
	    then
	    	echo "--------------------------------------------"
		    echo "php is already installed on this machine"
		    php -r \@phpinfo\(\)\; | grep 'PHP Version' -m 1
			echo "Do you want to reinstall php? "
			echo "--------------------------------------------"
		   	OPTIONS="Yes No Uninstall"
			select opt in $OPTIONS; do
		    if [ "$opt" = "Yes" ]; then
		   	    php_uninstall
			    php_install
			    exit
			elif [ "$opt" = "No" ]; then
				echo "---------------------------"
				echo "OK than, Have a nice day!"
				echo "---------------------------"
			exit	
			elif [ "$opt" = "Uninstall" ]; then
				php_uninstall
				exit
			else
				echo "--------------------------------"
			    echo "bad option please select 1 or 2"
			    echo "--------------------------------"
			fi
		done
		else
		php_install
	fi
	}

	php_version
}

function MySql(){ 

	function mysql_install(){

		debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'

		debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

		#Installing MySQL
		sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.7
		sudo apt-get -y install mysql-server

	}

	function mysql_uninstall(){
		
		#remove mysql from the system
		sudo apt-get -y purge mysql* 

		sudo apt-get -y autoremove \
					 autoclean -y

	}

	function mysql_version(){
		if which mysql > /dev/null
	    then
	    	echo "--------------------------------------------"
		    echo "MySql is already installed on this machine"
		    echo $(mysql -v)
			echo "Do you want to reinstall mysql? "
			echo "--------------------------------------------"
		   	OPTIONS="Yes No Uninstall"
			select opt in $OPTIONS; do
		    if [ "$opt" = "Yes" ]; then
		   	    mysql_uninstall
			    mysql_install
			elif [ "$opt" = "No" ]; then
				echo "---------------------------"
				echo "OK than, Have a nice day!"
				echo "---------------------------"
			exit	
			elif [ "$opt" = "Uninstall" ]; then
				mysql_uninstall
			exit
			else
				echo "--------------------------------"
			    echo "bad option please select 1 or 2"
			    echo "--------------------------------"
			fi
		done
		else
		mysql_install
	fi
	}

	mysql_version

}


function MariaDB(){ 

	function mariadb_install(){
		
		sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password root"

		sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password root" 

		#Installing MariaDB
		sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server-10.1 mariadb-client
		sudo apt-get -y install mariadb-server-10.1 mariadb-client

	}

	function mariadb_uninstall(){
		
		#remove mariadb from the system
		sudo apt-get -y purge mariadb* 

		sudo apt-get -y autoremove \
					 autoclean -y

	}

	function mariadb_version(){
		if which mariadb > /dev/null
	    then
	    	echo "--------------------------------------------"
		    echo "mariadb is already installed on this machine"
		    echo $(mariadb -v)
			echo "Do you want to reinstall mariadb? "
			echo "--------------------------------------------"
		   	OPTIONS="Yes No Uninstall"
			select opt in $OPTIONS; do
		    if [ "$opt" = "Yes" ]; then
		   	    mariadb_uninstall
			    mariadb_install
			elif [ "$opt" = "No" ]; then
				echo "---------------------------"
				echo "OK than, Have a nice day!"
				echo "---------------------------"
			exit	
			elif [ "$opt" = "Uninstall" ]; then
				mariadb_uninstall
			exit
			else
				echo "--------------------------------"
			    echo "bad option please select 1 or 2"
			    echo "--------------------------------"
			fi
		done
		else
		mariadb_install
	fi
	}

	mariadb_version

}

function package(){
	    echo "------------------------------------"
	    echo "Which package do you want to install"
		echo "------------------------------------"
	   	OPTIONS="PHP NGINX MySql MariaDB All Exit"
		select opt in $OPTIONS; do
	    if [ "$opt" = "PHP" ]; then
		    php7
		    exit
		elif [ "$opt" = "NGINX" ]; then
			nginx
		exit
	    	elif [ "$opt" = "MySql" ]; then
	    		MySql
	    	exit
	    	elif [ "$opt" = "MariaDB" ]; then
	    		MariaDB
	    	exit
		elif [ "$opt" = "All" ]; then
			php7
			nginx
	    		MariaDB
	    exit
	    elif [ "$opt" = "Exit" ]; then
	    	echo "---------------------------"
	    	echo "Ok than, have a nice day!"
	    	echo "---------------------------"
	    exit
		else
			echo "---------------------------------------"
		    echo "bad option please select 1, 2, 3, 4 or 5"
		    echo "---------------------------------------"
		fi
	done
}

package
