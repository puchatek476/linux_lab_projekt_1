#!/bin/bash

tar -czf obecnosc_arch/obecnosc_$(date +"%Y_%m").tar.gz /home/jakub/Documents/lab_projekt_1/obecnosc.txt
tar -czf obecnosc_arch/obecnosc_users_$(date +"%Y_%m").tar.gz /home/jakub/Documents/lab_projekt_1/monthly_users_presence
