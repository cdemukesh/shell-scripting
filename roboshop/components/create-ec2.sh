#!/bin/bash

#AMI_ID="ami-0c1d144c8fdd8d690"

AMI_ID=$(aws ec2 describe-images  --filters "Name=name, Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | awk -F "\"" '{print $2}')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')

echo -e "AMI ID used to launch the EC2 instance is : \e[32m$AMI_ID\e[0m"
echo -e "Security Group ID used to launch the EC2 instance is : \e[32m$SG_ID\e[0m"

echo -e "************ Launching Server ************"
aws ec2 run-instances \
    --image-id ${AMI_ID} \
    --instance-type t2.micro \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=NAME,Value=Payment}]'| jq .
