#!bin/bash

# Redirectors are of 2 types in bash

# 1) Input Redirectors (Means take input from the file)

#  < (Ex : sudo mysql </tmp/studentapp.sql) 

# 2) Output Redirectors (Means routing the output to a file)

# (>> appends the lastest output to the existing content)

#Outputs

#   1) Standard Output                    > or >> or 1>
#   2) Standard Error                     2> or 2>>
#   3) Standrad Output and standard Error &> or &>>

# ls -ltr > output.txt  # Redirects the output to output.txt
# ls -ltr >> output.txt # Redirects and appends the output to output.txt
# ls -ltr 2> output.txt # Redirects the error only to output.txt
# ls -ltr &> output.txt # Redirects the output or error output.txt

exit 1

echo hai