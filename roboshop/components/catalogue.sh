#!/bin/bash
source components/common.sh

COMPONENT=catalogue


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

echo -n "Updating the $COMPONENT systemd file : "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/$APPUSER/${COMPONENT}/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
stat $?

echo -n "Starting $COMPONENT service : "
systemctl daemon-reload &>> $LOGFILE
systemctl start $COMPONENT   &>> $LOGFILE
systemctl enable $COMPONENT  &>> $LOGFILE
stat $?

echo -e "\n*********************\e[32m ${COMPONENT^^} Installation is complete \e[0m*********************" 
