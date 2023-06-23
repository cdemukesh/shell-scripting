#!/bin/bash

COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[31mPlease run with root user or sudo privilege.\e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32mSUCCESS\e[0m"
    else
        echo -e "\e[31mFAILURE\e[0m"
    fi
}

echo -e "\n*********************\e[35m ${COMPONENT^^} Installation has started \e[0m*********************\n"
echo -n "Installing Nginx : "
yum install nginx -y    &>> $LOGFILE
stat $?

echo -n "Downloading the frontend component : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Performing Cleanup : "
cd /usr/share/nginx/html
rm -rf *    &>> $LOGFILE
stat $?

echo -n "Extracting ${COMPONENT} : "
unzip /tmp/${COMPONENT}.zip         &>> $LOGFILE
mv ${COMPONENT}-main/* .            &>> $LOGFILE
mv static/* .                   &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Updating the Backend component reverseproxy details : "
for component in catalogue ; do
    sed -i -e "/$component/s/localhost/$component.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
done
stat $?

echo -n "Starting ${COMPONENT} service : "
systemctl daemon-reload &>> $LOGFILE
systemctl enable nginx  &>> $LOGFILE
systemctl restart nginx   &>> $LOGFILE
stat $?

echo -e "\n*********************\e[32m ${COMPONENT^^} Installation is complete \e[0m*********************" 

