#! /bin/bash

# Write a script that backs up a directory into a compressed archive. Make sure to only keep the latest 5 backups.Older backups automatically deleted and also log success/failure to backup.log file.


FILE_NAME=$1
DATE=$(date +%d-%m-%y-%H-%M-%S)
BACKUP_DIR=/tmp/bkp

mkdir -p /tmp/bkp

zip -r -q $BACKUP_DIR/$DATE.zip $FILE_NAME


expr=$(ls -lt /tmp/bkp | head -6 | tail -5 | awk '{ print $9 }')

for file in $expr
do
	echo $file
	if [[ 

	
done
