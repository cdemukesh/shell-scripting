#!/bin/bash

COMPONENT=mongodb
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

echo -e "\n*********************\e[32m ${COMPONENT} Installation has started \e[0m*********************\n" | tr 'a-z' 'A-Z'
<<MUKESH
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

MUKESH
echo -e "\n*********************\e[32m ${COMPONENT} Installation is complete \e[0m*********************" | tr 'a-z' 'A-Z'
# 1. Setup MongoDB repos.

# ```bash
# # curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# ```

# 1. Install Mongo & Start Service.

# ```bash
# # yum install -y mongodb-org
# # systemctl enable mongod
# # systemctl start mongod

# ```

# 1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

# Config file:   `# vim /etc/mongod.conf`