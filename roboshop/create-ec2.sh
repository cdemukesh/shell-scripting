#!/bin/bash

#AMI_ID="ami-0c1d144c8fdd8d690"

COMPONENT=$1
ENV=$2
HOSTED_ZONE_ID="Z03679992SV9650RBIQI8"

if [ -z $COMPONENT ] || [ -z $ENV ] ; then
    echo -e "\e[31m COMPONENT NAME AND ENV IS NEEDED \e[0m"
    echo -e "\e[35m Ex Usage: \n\t\$ bash create-ec2.sh componentName envName\e[0m"
    echo -e "\e[35m\t\$ bash create-ec2.sh all \e[0m"
    exit 1
fi

AMI_ID=$(aws ec2 describe-images  --filters "Name=name, Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | awk -F "\"" '{print $2}')
SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')

echo -e "AMI ID used to launch the EC2 instance is : \e[35m$AMI_ID\e[0m"
echo -e "Security Group ID used to launch the EC2 instance is : \e[35m$SG_ID\e[0m"

# vpc-0d76e134047befa02

# COMMAND TO CREATE PRIVATE HOSTED ZONE
# aws route53 create-hosted-zone --name robo.internal \
#   --hosted-zone-config Comment='Testing using CLI',PrivateZone=true \
#   --vpc VPCRegion='us-east-1',VPCId='vpc-0d76e134047befa02' \
#   --caller-reference '2023-06-23'

create_ec2() {

        

        echo -e "\e[36m\n************ Launching $COMPONENT-$ENV Server ************\e[0m"
        IP_ADDRESS=$(aws ec2 run-instances --image-id ${AMI_ID} \
            --security-group-ids $SG_ID \
            --instance-type t2.micro \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]"| jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')

        echo -e "\e[36m************ Launching $COMPONENT-$ENV Server Completed ************\e[0m"
        echo -e "Private IP Address of $COMPONENT-$ENV is : \e[35m$IP_ADDRESS\e[0m"

        echo -e "\e[36mCreating DNS Record for the $COMPONENT-$ENV : \e[0m"
        sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${IP_ADDRESS}/" route53.json > /tmp/record.json
        aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} --change-batch file:///tmp/record.json

}

if [ $COMPONENT == "all" ] ; then

    for component in frontend mongodb catalogue redis user cart shipping mysql rabbitmq payment ; do

        COMPONENT=$component
        create_ec2
    
    done

else

    create_ec2

fi