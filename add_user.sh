#!/bin/bash

USERNAME=$1
GROUPTYPE=$2


# check for not being superuser
if [ $(id -u) -ne 0 ]; then
	echo "This script can be executed only by the root"
	exit 0
fi



# check for no arguments provided
if [ $# -lt 2 ]; then
	if [ $# -eq 1 ]; then
		echo "Missing one argument. Exiting."
		exit 0
	else
		echo "Missing two arguments. Exiting."
		exit 0
	fi
fi


# checking for correct user group type
if [ "$GROUPTYPE" != "f" ]; then
	if [ "$GROUPTYPE" != "b" ]; then
		echo "Invalid group type. Group type should be 'f' or 'b'. Exiting."
		exit 0
	fi
	
fi
GROUPNAME=''
if [ "$GROUPTYPE" == "f" ]; then
	GROUPNAME="frontend-dev"
else
	GROUPNAME="backend-dev"
fi


# checking if username already exists
grep "^$USERNAME" /etc/passwd > /dev/null
if [ $? -eq 0 ]; then
	echo "This username already exists. Exiting."
	exit 0
fi



# generating temporary password
gen_pass=$(</dev/urandom tr -dc A-Za-z0-9 | head -c 10)
encr_pass=$(perl -e 'print crypt($ARGV[0], "password")' $gen_pass)


# adding user
useradd -m -p "$encr_pass" "$USERNAME" > /dev/null
if [ $? -eq 0 ]; then
	echo "Succesfully added new user."
else
	echo "Problem has occured while adding new user. Exiting."
	exit 0
	
fi


# forcing user to change password at first login
passwd --expire $USERNAME > /dev/null
echo "Password: $gen_pass. User $USERNAME will be forced to change it when loggin for first time."


# adding new user to proper developer group
usermod -a -G "$GROUPNAME" "$USERNAME"


# configuring quota limits based on group
# frontend-dev have 4GB soft limit and backend-dev have 3GB soft limit
if [ "$GROUPTYPE" == "f" ]; then
	setquota -u $USERNAME 4G 5G 0 0 /
else
	setquota -u $USERNAME 3G 4G 0 0 /
fi

