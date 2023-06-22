#!/bin/bash

ID=id -u
if [ $ID -ne 0 ] ; then
    echo -e "\e[34m Please run with root user or sudo privilege.\e[0m"
    exit 1

fi
echo "Installing Nginx:"
yum install nginx -y

# The frontend is the service in RobotShop to serve the web content over Nginx.

# Install Nginx.

# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.