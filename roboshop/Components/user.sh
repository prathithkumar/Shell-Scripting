#!/bin/bash

# Validate the user who is running the script is a root user or not.

USER_ID=$(id -u)
COMPONENT=user
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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

echo -n "Configuring ${COMPONENT} repo"
curl --silent --location https://rpm.nodesource.com/setup_16.x |  bash - &>> ${LOGFILE}
stat $?

echo -n "Installing NodeJS :"
yum install nodejs -y  &>> ${LOGFILE}
stat $?

id ${APPUSER}          &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
    echo -n "Creating Application User Account :"
    useradd roboshop
    stat $?
fi     

echo -n "Downloading the ${COMPONENT} : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the ${COMPONENT} to ${APPUSER} home directory"
cd /home/${APPUSER}/
rm -rf ${COMPONENT}             &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip  &>> ${LOGFILE}
stat $?

echo -n "Changing the ownership :"
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/
stat $?

echo -n "Generating the ${COMPONENT} artifacts : "
cd /home/${APPUSER}/${COMPONENT}/
npm install       &>> ${LOGFILE}
stat $?

echo -n "Configuring the ${COMPONENT} system file :"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service

mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon-reload &>> ${LOGFILE}
systemctl enable ${COMPONENT} &>> ${LOGFILE}
systemctl restart ${COMPONENT} &>> ${LOGFILE}
stat $?

echo -e "\e[35m ${COMPONENT} Installation is completed \e[0m \n"