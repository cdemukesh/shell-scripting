#!/bin/bash


COMPONENT=rabbitmq
source components/common.sh

echo -e "\n*********************\e[35m ${COMPONENT^^} Installation has started \e[0m*********************\n"
echo -n "Configuring the ${COMPONENT} repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
stat $?

echo -n "Installing ${COMPONENT} : "
yum install -y ${COMPONENT}-server  &>> $LOGFILE
stat $?

echo -n "Starting ${COMPONENT} : "
systemctl daemon-reload      #&>> $LOGFILE
#systemctl daemon-reload mongod    &>> $LOGFILE
systemctl enable ${COMPONENT}-server     &>> $LOGFILE
systemctl restart ${COMPONENT}-server      &>> $LOGFILE
stat $?

echo -n "Creating the ${COMPONENT} ${APPUSER} : "
rabbitmqctl add_user roboshop roboshop123   &>> $LOGFILE
stat $?

echo -n "Configuring the ${COMPONENT} ${APPUSER} privileges : "
rabbitmqctl set_user_tags roboshop administrator            &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"    &>> $LOGFILE
stat $?