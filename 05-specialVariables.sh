#!/bin/bash

# Special variables gives special properties to your variables

# Here are few of the special variables: $0 to $9, $?, $*, $@

echo "Script Name: $0"
echo "Parameter 1: $1"
echo "Parameter 2: $2"
echo "Last execution?: $?"
echo "*: $*"
echo "@: $@"

echo -e "Print\n"
echo $*     # $* is going to print the used variables
echo $@     # $@ is going to print the used variables
echo $$     # $$ is going to print the PID of the current process
echo $#     # $# is going to pring the number of arguments
echo $?     # $? is going to print the exit code of the last command
echo $!     # $! is going to print the last argument of the command