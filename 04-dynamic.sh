#!/bin/bash

# TODAYS_DATE="03JUNE2023"
TODAYS_DATE=$(date +%F)                             # Always enclose expressions in paranthesis.
echo -e "Good Morning! Today's date is \e[32m${TODAYS_DATE}\e[0m"