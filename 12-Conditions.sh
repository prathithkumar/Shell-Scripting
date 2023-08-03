#!/bin/bash


# Conditions helps us to execute only if some factor is true and if that factor is false then that something wont be executed.


# Syntax of CASE

# case $var in 
#  opt1) commands-x ;;
#  opt2) commands-y ;;
# esac

ACTION=$1

case $ACTION in
    start) 
         echo -e "\e[33m Starting Payment Service \e[0m"
         exit 0
         ;;
    stop)
         echo -e "\e[31m Stopping Payment Service \e[0m"
         exit 1
         ;;
     restart)
        echo -e "\e[36m Restarting Payment Service \e[0m"
        exit 2       
        ;;
    *)
        echo -e "\e[35m Valid options are start or stop or restart \e[0m"
        echo -e "\e[36m Example Usage \e[0m :\n \t Bash scriptName Stop"
        exit 3
        ;;
esac
