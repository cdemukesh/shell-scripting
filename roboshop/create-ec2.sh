#!/bin/bash

#AMI_ID="ami-0c1d144c8fdd8d690"

COMPONENT=$1
HOSTED_ZONE_ID="Z03679992SV9650RBIQI8"

if [ -z $COMPONENT ] ; then
    echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m"
    echo -e "\e[35m Ex Usage: \n\t\$ bash create-ec2.sh componentName \e[0m"
    exit 1
fi

AMI_ID=$(aws ec2 describe-images  --filters "Name=name, Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | awk -F "\"" '{print $2}')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')

echo -e "AMI ID used to launch the EC2 instance is : \e[32m$AMI_ID\e[0m"
echo -e "Security Group ID used to launch the EC2 instance is : \e[32m$SG_ID\e[0m"

echo -e "************ Launching $COMPONENT Server ************"
IP_ADDRESS=$(aws ec2 run-instances --image-id ${AMI_ID} \
    --security-group-ids $SG_ID \
    --instance-type t2.micro \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"| jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')

echo -e "Private IP Address of $COMPONENT is : \e[32m$IP_ADDRESS\e[0m"

echo -e "C\e[36mCreating DNS Record for the $COMPONENT : \e[0m"
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IP_ADDRESS}/" route53.json > /tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} --change-batch file://rout53.json