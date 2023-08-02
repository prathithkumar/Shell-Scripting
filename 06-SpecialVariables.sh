#!/bin/bash

#Special Variables gives special properties to your variables

# Here are few of the special variables : $0 to $9, $? , $# , $* , $@

echo $0   # $0 prints the script name we are executing

echo "Name of recently Launched Rocket in India is $1"
echo "Popular EV Vehicle in Sweden is $2"
echo "Current Topic is $3"


echo $$     # $$ is going to print the PID of the current process
echo $#     # $# is going to print the number of arguments
echo $?     # $? is going to print the exit code of the last command.
echo $*     # $* is going to print the used arguments
echo $@     # $@ is goint to print the used arguments


#echo "Variables Used In the script $*"  # $* is going to print the used variables
#echo "Variables Used are $@"            # $@ is going to print the used variables  