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

echo -e "\e[32m I am printing Green Color \e[33m"