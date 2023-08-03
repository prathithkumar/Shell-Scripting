#!/bin/bash


<<COMMENT
if condition is ideally available in 3 formats :

  1) Simple if
  2) If Else 
  3) Else If 


1) Simple If :

  if [ expression ]; then
          commands
  fi 

  command are going to be executed only if the expression is true

* What will happen if the expression fails ? Simple, commands wont be executed.

2) if-Else 
     
      if [ expression ]; then
              
            command 1

    else 

            command 3
    fi         

 If expression is true,then command-1 will be executed. If the expression is not true, the command-2 will be execueted.


3) Else - if 
    
    if [ expression1 ]; then
              
            command 1

    elif [ expression2 ] ; then

            command 2

    elif [ expression3 ] ; then

            command 3

    else 

            command 4       
    fi         

COMMENT

# Whta is an expression???

Whenver we are using operators to perform something, thats reffered as an expression.

echo "Demo on if Usage"

ACTION=$1

if [ "$ACTION" == "start"]; then
     echo  -e "\e[33m Starting Payment Service \e[0m"
     exit

fi    