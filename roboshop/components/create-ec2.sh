#!/bin/bash

#AMI_ID="ami-0c1d144c8fdd8d690"

AMI_ID=$(aws ec2 describe-images  --filters "Name=name, Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | awk -F "\"" '{print $2}')

echo -e "AMI ID used to launch the EC2 instance is : \e[32m$AMI_ID\e[0m"

aws ec2 run-instance --image-id ${AMI_ID} --instance-type t2.micro