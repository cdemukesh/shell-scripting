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

# I want this to be executed only if the default password reset was not done.
echo "exit" | mysql -uroot -pRoboShop@1    &>> $LOGFILE     # use "exit" or "show databases;" with a ';'
if [ $? -ne 0 ] ; then
    echo -n "Performing password reset of root user : "
    echo "ALTER user 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -p${DEFAULT_ROOT_PASSWORD}  &>> $LOGFILE
    stat $?
fi

# Validate and remove the validate_password plugin.
echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password   &>> $LOGFILE     # use "exit" or "show databases;" with a ';'
if [ $? -eq 0 ] ; then
    echo -n "Uninstall the validate_password plugin : "
    echo "UNINSTALL PLUGIN validate_password;" | mysql -uroot -pRoboShop@1    &>> $LOGFILE
    stat $?
fi

echo -n "Downloading the ${COMPONENT} : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"    &>> $LOGFILE
stat $?

echo -n "Extracting the ${COMPONENT} schema : "
cd /tmp
unzip -o ${COMPONENT}.zip
cd ${COMPONENT}-main
mysql -u root -pRoboShop@1 <shipping.sql
stat $?