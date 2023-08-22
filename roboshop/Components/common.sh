# All the common fucntions will be declared here. Rest of the components will be sourcing the functions from its files.


LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

USER_ID=$(id -u)

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
# Function to create a user account
CREATE_USER(){
    id ${APPUSER}          &>> ${LOGFILE}
    if [ $? -ne 0 ] ; then
    echo -n "Creating Application User Account :"
    useradd roboshop
    stat $?
    fi   
}




DOWNLOAD_AND_EXTRACT() {

        echo -n "Downloading the ${COMPONENT} : "
        curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
        stat $?


        echo -n "Downloading the ${COMPONENT} : "
        curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
        stat $?

        cd /home/${APPUSER}/
        rm -rf ${COMPONENT}             &>> ${LOGFILE}
        unzip -o /tmp/${COMPONENT}.zip  &>> ${LOGFILE}
        stat $?

        echo -n "Changing the ownership :"
        mv ${COMPONENT}-main ${COMPONENT}
        chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/
        stat $?

}

CONFIG_SVC(){

    echo -n "Configuring the ${COMPONENT} system file :"
    
    sed -i -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e   's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
    mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    stat $?

    echo -n "Starting the ${COMPONENT} service :"
    systemctl daemon-reload &>> ${LOGFILE}
    systemctl enable ${COMPONENT} &>> ${LOGFILE}
    systemctl restart ${COMPONENT} &>> ${LOGFILE}
    stat $?
}
# Declaring a NodeJS function
NODEJS() {

        echo "Configuring ${COMPONENT}"

        echo -n "Configuring ${COMPONENT} repo :"
        curl --silent --location https://rpm.nodesource.com/setup_16.x |  bash - &>> ${LOGFILE}
        stat $?

        echo -n "Installing NodeJS :"
        yum install nodejs -y  &>> ${LOGFILE}
        stat $?
 
       CREATE_USER            # Calls CREATE_USER functiom that creates User account:

       DOWNLOAD_AND_EXTRACT  # Downloading and extracts the components

       echo -n "Generating the ${COMPONENT} artifacts : "
       cd /home/${APPUSER}/${COMPONENT}/
       npm install       &>> ${LOGFILE}
       stat $? 

       CONFIG_SVC
       


} 

MVN_PACKAGE() {
          echo -n "Generating the ${COMPONENT} artifacts :"
          cd /home/${APPUSER}/${COMPONENT}/
          mvn clean package  &>> ${LOGFILE}
          mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar
          stat $?
}

JAVA() {
        echo "Configuring ${COMPONENT}"


        echo -n "Installing manven:"
        yum install maven -y   &>> ${LOGFILE}
        stat $?

        CREATE_USER            # Calls CREATE_USER functiom that creates User account:

        DOWNLOAD_AND_EXTRACT  # Downloading and extracts the components

        MVN_PACKAGE

        CONFIG_SVC

      
}
