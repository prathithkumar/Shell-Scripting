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
         echo "Starting Payment Service"
         ;;
    stop)
         echo "Stopping Payment Service"
         ;;
     restart)
        echo "Restarting Payment Service"       
        ;;
    *)
        echo "Valid options are start or stop or restart"
        echo "Example Usage : Bash scriptName Stop"
        ;;
esac
