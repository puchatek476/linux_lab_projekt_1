#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "This script can be executed only by root. Exiting."
	exit 0
fi

apt-get -y update
apt-get -y upgrade
apt -y update
apt -y upgrade

# git
apt -y install git
# vim
apt-get -y install vim
# gcc compiler
apt -y install build-essential
#  filezilla
apt-get -y install filezilla
# calculator
apt -y install bc
# vs code
snap install code --classic
echo "Successfully installed all software"
