#!/bin/bash

## 
#  This is the update script for Ruby Intro - it is to be run when the SaaS community makes changes to the CHIP assignments.
#  To run:   bash .guides/updates.sh
#  These are project specific!
#  Ensure that the branches stated below are the appropriate ones for pulling the update.
##

# Remove duplicated files



# Pull saas repos
git submodule foreach --recursive git pull

git submodule status


# Re-copy fresh versions of the files




printf "\n\nUpdate has reached end of script without error. \n\nPlease manually check functionality before:"
printf "\n(1) pushing to codio-content repo \n(2) updating codio-content course \n\n"