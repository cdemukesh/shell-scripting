#!/bin/bash

# Each and every color we see on terminal will have a color code and we need to use that code based on our need.

# Color     Foreground Code	    Background Code

# Red	        31                  41

# Green	        32	                42

# Yellow	    33	                43

# Blue	        34	                44

# Magenta       35                  45

# Cyan          36                  46



# The syntax to print the colors is:
# Eg:
#       echo -e "\e[COL-CODEm Your Message To Be Printed. \e[0m"
#       echo -e "\e[32m I am printing Green Color \e[0m"

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${RED}This is some red text, ${ENDCOLOR}"
echo -e "${GREEN}And this is some green text${ENDCOLOR}"

echo -e "\e[31m I am printing Red Color \e[0m"
echo -e "\e[32m I am printing Green Color \e[0m"
echo -e "\e[33m I am printing Yellow Color \e[0m"
echo -e "\e[43;34m I am printing Blue Color \e[0m"
echo -e "\e[35m I am printing Magenta Color \e[0m"
echo -e "\e[36m I am printing Cyan Color \e[0m"
