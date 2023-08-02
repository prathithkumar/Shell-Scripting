#!/bin/bash

echo "$$"     # $$ is going to print the PID of the current process
echo "$#"     # $# is going to print the number of arguments
echo "$?"     # $? is going to print the exit code of the last command.
echo "$*"     # $* is going to print the used arguments
echo "$@"     # $@ is goint to print the used arguments

#Here we tried the above commands by inserting double quotes

#Below we are trying with only single quotes lets see the difference

echo '$$'     # $$ is going to print the PID of the current process
echo '$#'     # $# is going to print the number of arguments
echo '$?'     # $? is going to print the exit code of the last command.
echo '$*'     # $* is going to print the used arguments
echo '$@'     # $@ is goint to print the used arguments

# single quotes will supress the power of a special variable
# Whenever we have any special variable, prefer to avoid single quotes and go with double quotes
