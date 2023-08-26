#!/bin/bash

COMPONENT=$1
ENV=$2
INSTANCE_TYPE="t3.micro"
HOSTEDZONEID="Z05528692BAIDU4FZAFQL"


if [ -z $1 ] || [ -z $2 ] ; then 
   echo -e "COMPONENT NAME IS NEEDED"
   echo -e "Ex Usage $ bash launch-ec2.sh shipping"
   exit 1
fi  

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7-Backup"| jq ".Images[].ImageId" | sed -e 's/"//g')"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allowall | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')"

create_ec2(){



    echo  -e "****** Creating ${COMPONENT} Server Is In Progress *******"
    PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE}  --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq '.Instances[].PrivateIpAddress' |  sed -e 's/"//g')

    echo -e "Private IP Address of the $COMPONENT-${ENV} is $PRIVATEIP \n\n"
    echo -e "Creating DNS Record of ${COMPONENT} :"

    sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json  >  r53.json

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file://r53.json
    echo -e "Creating DNS Record for the $COMPONENT has completed"
}


if [ "$1" == "all" ]; then

    for component in mongodb catalogue cart user shipping frontend payment mysql redis rabbitmq; do
        COMPONENT=$component
        create_ec2
    done

else    
        create_ec2
fi



