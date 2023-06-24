#!/bin/bash


COMPONENT=redis
source components/common.sh

echo -e "\n*********************\e[35m ${COMPONENT^^} Installation has started \e[0m*********************\n"

echo -n "Configuring the ${COMPONENT} repo : "
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo
stat $?


echo -n "Installing ${COMPONENT} : "
yum install -y ${COMPONENT}-6.2.11  &>> $LOGFILE
stat $?

echo -n "Enabling the DB visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}/${COMPONENT}.conf
stat $?

echo -n "Starting ${COMPONENT} : "
systemctl daemon-reload ${COMPONENT}    &>> $LOGFILE
systemctl enable ${COMPONENT}     &>> $LOGFILE
systemctl restart ${COMPONENT}      &>> $LOGFILE
stat $?


echo -e "\n*********************\e[32m ${COMPONENT^^} Installation is complete \e[0m*********************" 
