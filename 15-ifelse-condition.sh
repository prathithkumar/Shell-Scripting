#!/bin/bash

echo "Demo on if Usage"

ACTION=$1
 
if [ "$ACTION" == "start" ]; then
     echo  "Starting Payment"
     exit 0

elif ["$ACTION" == "stop"]; then
     echo "stopping payment"
     exit 1

elif ["$ACTION" == "stop"]; then
     echo "Restarting payment"
     exit 2

else
    echo -e "\e[35m Valid options are start or stop or restart \e[0m"
    echo -e "\e[36m Example Usage \e[0m :\n \t Bash scriptName Stop"
    exit 3
    
fi 