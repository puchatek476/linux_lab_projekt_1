#!/bin/bash

# checking for not being root
if [ $(id -u) -ne 0 ]; then
	echo "Only root can run this command"
	exit 0
fi

# check if frontend-dev and backend-dev groups already exists
# if not, creating them
grep "^frontend-dev" /etc/group > /dev/null
if [ $? -ne 0 ]; then
	groupadd "frontend-dev"
fi
grep "^backend-dev" /etc/group > /dev/null
if [ $? -ne 0 ]; then
	groupadd "backend-dev"
fi
