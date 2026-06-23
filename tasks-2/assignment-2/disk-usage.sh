#! /bin/bash

DISK_PATH=/System/Volumes/Data
DISK_USAGE=$(df -h $DISK_PATH | awk '{ print $5 }' | tr -d "%")


for u in $DISK_USAGE
do
	if [[ $u -gt $1 ]]; 
	then
		echo warning : $DISK_PATH $u% full.
	fi
done
