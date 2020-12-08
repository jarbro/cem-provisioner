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
ANSIBLEPATH=<PATH TO QUICNYS ANSIBLE SCRIPTS>
#
# Grab keys from CyberArk Vault
aws_keys=( $(./clipasswordsdk getpassword -p AppDescs.AppID=<Your App ID> -p Query="<Enter Your Safe Query String>" -p RequiredProps=* -o Password,PassProps.AWSAccessKeyID | tr ',' '\n'))
#
export AWS_SECRET_ACCESS_KEY= echo ${aws_keys[0]}
export AWS_ACCESS_KEY_ID= echo ${aws_keys[1]}
# ----------------------------------
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

Provision(){
	ansible-playbook $ANSIBLEPATH/aws/aws-setup.yml
        pause
}
 
# do something in two()
Deprovision(){
	ansible-playbook $ANSIBLEPATH/aws/aws-cleanup.yml
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
