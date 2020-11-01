#!/usr/bin/env bash
################################################################################
# Script name: keepScrollbackBuffer.sh
# Author: Marco Tijbout - CrossCloud.Guru
# License: GNU GPL v2.0
# Version: 1
#
# History:
#   1 - Initial released version
#
# Purpose:
#   Modify the terminal settings to avoid clear to clear the scrollback buffer
#
# Usage:
#   - Run this script on linux flavoured system with the bash shell.
#   - Settings are set globally for the system. Remove sudo from 'sudo tic' to
#   make it user bound.
#
# Improvement ideas:
#   -
################################################################################

# Current date and time of script execution
DATETIME=`date +%Y%m%d_%H%M`

# Display current terminal type:
echo $TERM

# Store the current terminal settings in a backup file
infocmp -x $TERM > terminal-settings.backup-${DATETIME}

# Store the current terminal settings in a file to work with
infocmp -x $TERM > terminal-settings.new-${DATETIME}

# Store the value to search for in variable
# We need to remove the string: 'E3=\E[3J, ' but it contains the \ and [ special
# characters. These need to be escaped with an extra \
VALUE='E3=\\E\[3J, '

# Search for variable in file and remove it from file
sed -i '/'"$VALUE"'/s///g' terminal-settings.new-${DATETIME}

# Load modified termininfo and store it
sudo tic -x terminal-settings.new-${DATETIME}

# Restart the terminal to take changes into effect.
