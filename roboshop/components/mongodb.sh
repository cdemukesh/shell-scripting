#!/bin/bash


COMPONENT=mongodb
source components/common.sh

echo -e "\n*********************\e[35m ${COMPONENT^^} Installation has started \e[0m*********************\n"
echo -n "Configuring the ${COMPONENT} repo : "
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT} : "
yum install -y ${COMPONENT}-org  &>> $LOGFILE
stat $?

echo -n "Enabling the DB visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting ${COMPONENT} : "
systemctl daemon-reload      #&>> $LOGFILE
#systemctl daemon-reload mongod    &>> $LOGFILE
systemctl enable mongod     &>> $LOGFILE
systemctl restart mongod      &>> $LOGFILE
stat $?


echo -n "Downloading the ${COMPONENT} schema : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Extracting the ${COMPONENT} schema : "
cd /tmp
unzip -o ${COMPONENT}.zip   &>> $LOGFILE 
stat $?

echo -n "Injecting the schedma : "
cd ${COMPONENT}-main
mongo < catalogue.js    &>> $LOGFILE
mongo < users.js        &>> $LOGFILE
stat $?


echo -e "\n*********************\e[32m ${COMPONENT^^} Installation is complete \e[0m*********************" 
