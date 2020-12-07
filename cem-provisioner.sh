#!/bin/bash
#
A menu driven shell script to provision/deprovision CEM 
# Update all details with your own between <>
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
#
# This will be updated to a more secure manner in the next release
export AWS_SECRET_ACCESS_KEY=<Your Secret Access Key>
export AWS_ACCESS_KEY_ID=<Your AWS Access Key>
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

Provision(){
	ansible-playbook <Path to Ansible playbooks>/aws/aws-setup.yml
        pause
}
 
# do something in two()
Deprovision(){
	ansible-playbook <Path to Ansible playbooks>/aws/aws-cleanup.yml
        pause
}
 
# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " CEM ANSIBLE MENU "
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Provision CEM"
	echo "2. Deprovision CEM"
	echo "3. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 3 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [1 - 3] " choice
	case $choice in
		1) Provision ;;
		2) Deprovision ;;
		3) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus
	read_options
done