#!/bin/bash

# Redirectors are of 2 types in bash
#   1) Input Redirector     (Take input from the file)      : <
#   2) Output Redirector    (Routing the output to a file)  : > >> or 1>

# Outputs:
#   1) Standard Output  : > >> or 1>     Output which is show after execution on screen Eg: $cat /etc/passwd
#   2) Standard Error   : 2>            Output which is not expecting on the output Eg: $cat /etc/passwdffssa
#   3) Standard Output & Error  :    &> This will capture error and standard output


ls -lrt > op.txt    # Redirects the output to the op.txt file
ls -lrt >> op.txt   # Redirects the output to op.txt file by appending to the existing content
ls -lrt &> op.txt   # Rearrects botn standardout and standardErrors
ls -lrt 2> op.txt   # Redirects only the standara

# Each and every action in Linux will have an exit which determines the status of the completion,
# Range of exit codes is 0 to 255 
#   0       : Successful,Normal
#   1-255   : Unsuccessful, Abnormal, Failure, Partial Success