#!/bin/bash


COMPONENT=mysql
source components/common.sh

echo -e "\n*********************\e[35m ${COMPONENT^^} Installation has started \e[0m*********************\n"
echo -n "Configuring the ${COMPONENT} repo : "
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo
stat $?

echo -n "Installing ${COMPONENT} : "
yum install -y ${COMPONENT}-community-server  &>> $LOGFILE
stat $?

echo -n "Starting ${COMPONENT} : "
systemctl daemon-reload      #&>> $LOGFILE
#systemctl daemon-reload mongod    &>> $LOGFILE
systemctl enable mysqld     &>> $LOGFILE
systemctl restart mysqld      &>> $LOGFILE
stat $?

echo -n "Fetching default root password : "
DEFAULT_ROOT_PASSWORD=$(grep "temporary password" mysqld.log  | awk -F ": " '{print $2}')
stat $?

echo -n "Performing password reset of root user : "
echo "ALTER user 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -p${DEFAULT_ROOT_PASSWORD}
stat $?


# grep "temporary password" mysqld.log  | awk -F ": " '{print $2}'