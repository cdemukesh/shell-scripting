#!/bin/bash

# Variable is used to store and pass values

# In bash there is no concept of data type. 

#####################################
# BY DEFAULT EVERYTHING IS A STRING #
#####################################

# This is how we can declare variables in Bash

a=10
b=20
c=30

# Syntax : $variable : $ is going to print the value of the variable.
echo $a
echo -e "\e[33mValue of the variable a is: ${a}\e[0m"