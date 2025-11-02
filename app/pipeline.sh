#!/bin/sh
# @echo off
ASK="Choose 1 or 2: "
echo "1-GET or 2-POST"

read -p "$ASK" req
# pause
if [ "$req" -eq "1" ]
	read -p "Enter the userId" uid
	curl -X GET localhost:3200/api/admin/cooperatives/$uid
# elif [ "$req" -eq "2"] 
#  	curl -X POST localhost:3200/api/admin/cooperatives H "Content-Type: application/json" -d set /p data="kteb chi haja"
else
	echo "WRONG INPUT... EXITING"
	exit
fi