#!/bin/bash

set -e

# Validate the user who is running the script is a root user or not.
COMPONENT=rabbitmq


source Components/common.sh


echo "Configuring ${COMPONENT}"

echo -n "Configuring ${COMPONENT} repositories: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> ${LOGFILE}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> ${LOGFILE}
stat $?

echo -n "Installing ${COMPONENT} : "
yum install rabbitmq-server -y &>> ${LOGFILE}
stat $?

echo -n "Starting {$COMPONENT}"
systemctl enable rabbitmq-server &>> ${LOGFILE}
systemctl start rabbitmq-server  &>> ${LOGFILE}
stat $?

sudo rabbitmqctl list_users | grep roboshop &>> ${LOGFILE}
if [ $? -ne 0 ] ; then 
    echo -n "Creating ${COMPONENT} user account :"
    rabbitmqctl add_user roboshop roboshop123 &>> ${LOGFILE}
    stat $?
fi

echo -n "Configuring the permissions : "
rabbitmqctl set_user_tags roboshop administrator  &>> ${LOGFILE}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> ${LOGFILE}
stat $?


echo -e "Installation is Completed"