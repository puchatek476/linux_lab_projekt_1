#!/bin/bash

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > tmp.txt
for usr in $(cat tmp.txt); do
	grep -E $(date +'%Y-%m').\{10}$usr /home/jakub/Documents/lab_projekt_1/obecnosc.txt > tmp2.txt
	cut -c 1-10 tmp2.txt > /home/$usr/obecnosc_$(date +"%Y-%m").txt
	cp /home/$usr/obecnosc_$(date +"%Y-%m").txt /home/jakub/Documents/lab_projekt_1/monthly_users_presence/obecnosc_"$usr"_$(date +"%Y-%m").txt
done
