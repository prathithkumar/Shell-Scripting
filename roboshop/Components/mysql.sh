#!/bin/bash

COMPONENT=mysql

source Components/common.sh

echo "Configuring ${COMPONENT}"

echo -n "Configuring ${COMPONENT} repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo 
stat $?

echo -n "Installing ${COMPONENT}"
yum install mysql-community-server -y   &>> ${LOGFILE}
stat $?

echo -n "Starting ${COMPONENT}"
systemctl enable mysqld     &>>  ${LOGFILE}
systemctl start  mysqld     &>>  ${LOGFILE}
stat $?

echo -n "Extracting the default mysql root password"
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?


echo "Show databases;" | mysql -uroot -pRoboShop@1 &>> ${LOGFILE}
if [ $? -ne 0 ]; then
   echo -n "Performing default password reset of root account"
   echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD &>> ${LOGFILE}
   stat $?
fi

echo "Show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password &>> ${LOGFILE}
if  [ $? -eq 0 ]; then
    echo -n "Uninstalling Password-validate plugin :"
    echo "Uninstall plugin Validate_password" | mysql -uroot -pRoboShop@1  &>>  ${LOGFILE}
    stat $?
fi

DOWNLOAD

echo -n "Extracting the schema: "
unzip -o /tmp/${COMPONENT}.zip
stat $?

echo -n "Injecting the schema"
cd /${COMPONENT}-main
ls -ltr ${COMPONENT}-main
mysql -u root -pRoboShop@1 </tmp/mysql-main/shipping.sql  &>>  ${LOGFILE}
stat $?

echo {${COMPONENT} Installation is Completed}

