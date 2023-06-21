#!/bin/bash

# Special variables gives special properties to your variables

# Here are few of the special variables: $0 to $9, $?, $*, $@

echo "Script Name: $0"
echo "Parameter 1: $1"
echo "Parameter 2: $2"
echo "Last execution?: $?"
echo "*: $*"
echo "@: $@"