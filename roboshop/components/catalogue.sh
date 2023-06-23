#!/bin/bash

COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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
echo -n "Configuring the ${COMPONENT} repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -    &>> $LOGFILE
stat $?

echo -n "Installing NodeJS : "
yum install -y nodejs  &>> $LOGFILE
stat $?

id ${APPUSER}   &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating the Service Account : "
    useradd robos$APPUSER
    stat $?
fi

echo -n "Downloading the ${COMPONENT} : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"    &>> $LOGFILE
stat $?

echo -n "Copying the $COMPONENT to $APPUSER home directory : "
cd /home/$APPUSER/
rm -rf $COMPONENT   &>> $LOGFILE
unzip -o /tmp/${COMPONENT}.zip &>> $LOGFILE
stat $?

echo -n "Modifying the ownership : "
mv ${COMPONENT}-main ${COMPONENT}
chown -R $APPUSER:$APPUSER /home/$APPUSER/
stat $?

echo -n "Generating npm $COMPONENT artifacts : "
cd /home/$APPUSER/${COMPONENT}
npm install &>> $LOGFILE
stat $? 

