#!/bin/bash

## The shebang line tells the operating system which interpreter to use to parse the remainder of a file or a script. 
## The presence of a shebang indicates that a file is executable. When the shebang line is missing, 
## #!/bin/bash is the default shell used to execute the file. 


## Start of the line in any bash script should always be a SHEBANG NOTATION.

## Apart from the first line, none of the lines are considered as SHEBANG
## Shebang notation should always start with #

## Using the SHEBANG notation, we are telling the system interpretor to run the scrupt.


### How to run a linux script ?

    # * bash scriptName.sh
    # * sh scriptName.sh
    # * ./scriptName

echo Welcome to the new project!

# Printing Multiple Lines

echo Line1
echo Line2

# In bash, we have some escape sequence characters, using that we can add some power to the code.
# \n : new line
# \t : tab space.

echo -e "Line3\n\tLine4"