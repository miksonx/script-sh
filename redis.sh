#!/bin/bash

#Function for checking if theres any Redis pre-installed on your system
function redis_version(){
	if which redis-server > /dev/null
	    then
	    	echo "--------------------------------------------"
		    echo "redis is already installed on this machine"
		    echo $(redis-server -v)
			echo "Do you want to reinstall redis? "
			echo "--------------------------------------------"
		   	OPTIONS="Yes No Uninstall"
			select opt in $OPTIONS; do
		    if [ "$opt" = "Yes" ]; then
		   	    redis_uninstall
			    redis_install
			elif [ "$opt" = "No" ]; then
				echo "---------------------------"
				echo "OK than, Have a nice day!"
				echo "---------------------------"
			exit	
			elif [ "$opt" = "Uninstall" ]; then
				redis_uninstall
			exit
			else
				echo "--------------------------------"
			    echo "bad option please select 1 or 2"
			    echo "--------------------------------"
			fi
		done
		else
		redis_install
	fi
}

#redis install function
function redis_install(){
	#update and upgrade
	sudo apt-get -y update
	sudo apt-get -y redisupgrade

	#Install Redis on ubuntu
	sudo apt-get -y install redis-server

	#install PHP redis
	sudo apt-get -y install php-redis

	#enable redis as a cache server with max memory
	echo "maxmemory 128mb" | sudo tee -a /etc/redis/redis.conf
	echo "maxmemory-policy allkeys-lru" | sudo tee -a /etc/redis/redis.conf

	#restart redis service
	sudo systemctl restart redis-server.service

	#enable redis to run on next reboot
	sudo systemctl enable redis-server.service

	#Show the status of the redis server
	sudo systemctl status redis-server.service

	#enter redis server
	redis-cli

exit
}

function redis_uninstall(){
	echo "---------------------------"
	echo "Commencing redis uninstall"
	echo "---------------------------"
	sudo apt-get -y purge --auto-remove redis-server
	sudo rm -r sudo rm /usr/local/bin/redis-* \
	-r /etc/redis/ \
	/var/log/redis_* \
	-r /var/lib/redis/ \
	/var/run/redis_*
	echo "--------------------------------"
	echo "Redis succsesfully uninstalled"
	echo "--------------------------------"
}

redis_version

