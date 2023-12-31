#!/bin/bash

# Validate the user who is running the script is a root user or not.

USER_ID=$(id -u)
COMPONENT=mongodb
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
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT} :"
yum install -y mongodb-org &>> ${LOGFILE}
stat $?

echo -n "Enabiling the ${COMPONENT} visibility: "
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
stat $?

echo -n "Starting the ${COMPONENT} : "
systemctl enable mongod    &>> ${LOGFILE}
systemctl start mongod     &>> ${LOGFILE}         
stat $?

echo -n "Downloading the ${COMPONENT} schema: "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Extracting the ${COMPONENT} Schema: "
cd /tmp
unzip -o ${COMPONENT}.zip &>> ${LOGFILE}
stat $?


echo -n "Injecting ${COMPONENT} schema:"
cd ${COMPONENT}-main
mongo < catalogue.js   &>> ${LOGFILE}
mongo < users.js       &>> ${LOGFILE}
stat $?

echo {${COMPONENT} Installation is Completed}
