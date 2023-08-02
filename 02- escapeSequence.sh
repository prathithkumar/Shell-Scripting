#!/bin/bash
# \n ---> this indicates a new lines
# Prathith\nKumar ---> This will print in two lines as we inserted \n in middle.
# we need to use "-e" for the above line as it was a special character.
echo Line1

echo Line2
echo -e "Prathith\nKumar"

#Whenever we use special characters, always enclose them in double quotes --->  ""