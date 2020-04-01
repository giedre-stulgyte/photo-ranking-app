#!/bin/bash

read -p "App Name ($( [  ! -z $APP_NAME ] && echo ${APP_NAME})): " app_name
if [ ! -z ${app_name} ]; then
	export APP_NAME=${app_name}
elif [ -z $APP_NAME ]; then 
	echo "Missing app name; Aborting"; 
	return
fi

return 1