#!/bin/bash

# Validate the user who is running the script is a root user or not.

USER_ID=$(id -u)
COMPONENT=redis
LOGFILE="/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[32m Script is expected to executed by the root user or with a sudo privilage \e[0m \n \t Example: \n\t\t sudo bash wrapper.sh frontend"
    exit 1
fi 

stat() {
    if [ $1 -eq 0 ]; then 
      echo -e "\e[32m success \e[0m"
    else
      echo  -e "\e[31m failure \e[0m"
      exit 2
    fi 
}

echo "Configuring ${COMPONENT}"

echo "Configuring ${COMPONENT} repo"
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/redis.repo -o /etc/yum.repos.d/${COMPONENT}.repo &>> ${LOGFILE}
stat $?

echo -n "Installing ${COMPONENT} :"
yum install redis-6.2.12 -y &>> ${LOGFILE}
stat $?

echo -n "Enabiling the ${COMPONENT} visibility: "
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${COMPONENT}.conf
stat $?

echo -n "Starting the ${COMPONENT} : "
systemctl daemon-reload          &>> ${LOGFILE} 
systemctl enable ${COMPONENT}    &>> ${LOGFILE}
systemctl start  ${COMPONENT}    &>> ${LOGFILE}         
stat $?






echo {${COMPONENT} Installation is Completed}