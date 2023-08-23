#!/bin/bash

COMPONENT=$1
if [ -z $1 ] ; then 
   echo -e "COMPONENT NAME IS NEEDED"
   echo -e "Ex Usage $ bash launch-ec2.sh shipping"
   exit 1
fi  


AMI_ID="ami-0c1d144c8fdd8d690"
INSTANCE_TYPE= "t3.micro"
SG_ID="sg-0e1221dcbe704dc32"

$ aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE}  --key-name MyKeyPair --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" 


