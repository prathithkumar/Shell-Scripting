#!/bin/bash

# what is variable?
# Its generally used to hold some values dynamically

# Below was how we declare varaiable

a=10        # here a is integer
b=20        # b is also interger
c=30        # c is integer    
d=makjsd    # d is a string
DATE = "02AUG2023"


# There is no concept of Data types in Linux or Shell Scrpiting
# By default everything is a string
# if the input or varaibles are having some special characters, enclose them always in double quotes
# how to print the value of varaibles? Below are the answeers
#Using special characters, we are going to print the value of the variables

# $ --> $ is a special character used to print the value of the variables.

echo a
echo $a

echo ${a}

echo  "Todays date is $DATE"

# Both $a and ${a} works, Both are same. Prefer to use in flower Brackets

# DATA_DIR=robot

# rm -rf /data/${DATA_DIR}/ 