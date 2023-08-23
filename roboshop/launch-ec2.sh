#!/bin/bash

COMPONENT=$1
if [ -z $1 ] ; then 
   echo -e "COMPONENT NAME IS NEEDED"
   echo -e "Ex Usage $ bash launch-ec2.sh shipping"
   exit 1
fi  


AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7"| jq ".Images[].ImageId" | sed -e 's/"//g')"
INSTANCE_TYPE="t3.micro"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allowall | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')"
HOSTEDZONEID="Z05528692BAIDU4FZAFQL"

echo  -e "****** Creating ${COMPONENT} Server Is In Progress *******"
PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE}  --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' |  sed -e 's/"//g')

echo -e "Private IP Address of the $COMPONENT is $PRIVATEIP \n\n"
echo -e "Creating DNS Record of ${COMPONENT} :"

sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json  >  /tmp/r53.json
aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/r53.json
echo -e "Private IP Address of the $COMPONENT is created and ready to use on ${COMPONENT}.roboshop.internal"




