#!/bin/bash

# There are 4 types of commands available :

# 1) Binary   ( /bin , /sbin )
# 2) alias    ( alias are shortcuts, alias net="netstat -tulpn" )
# 3) Shell Built-in Commands
# 4) Functions  # Functions are nothing but a set of command that can be written in a sequence and can be called n number of times as per 

# how to declare a function ?

# below is how we declare a function
# f() {
#     echo hai
# }

# below is how we call a function
# f

sample(){
    echo This is a test for command function
    echo if you see this the function command was successfully executing
    echo Bye 
}

sample

echo test call

sample