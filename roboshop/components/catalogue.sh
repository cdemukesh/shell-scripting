#!/bin/bash

COMPONENT=catalogue
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

echo -e "\n*********************\e[32m ${COMPONENT^^} Installation has started \e[0m*********************\n"
echo -n "Configuring the ${COMPONENT} repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
stat $?

# echo -n "Installing ${COMPONENT} : "
# yum install -y nodejs  &>> $LOGFILE
# stat $?


