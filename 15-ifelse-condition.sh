#!/bin/bash

echo "Demo on if Usage"

ACTION=$1

if [ "$ACTION" == "start"]; then
     echo  -e "\e[33m Starting Payment Service \e[0m"
     exit

fi 