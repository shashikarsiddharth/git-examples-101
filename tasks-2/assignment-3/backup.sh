#! /bin/bash

FILE_NAME=$1
DATE=$(date +%d-%m-%y-%H-%M-%S)
BACKUP_DIR=/tmp/bkp

mkdir -p $BACKUP_DIR

zip -r -q $BACKUP_DIR/$DATE.zip $FILE_NAME 

ACTIVE_FILES=$(ls -lt $BACKUP_DIR | head -6 | tail -5 | awk '{ print $9 }')
ALL_FILES=$(ls -lt $BACKUP_DIR | awk '{ print $9 }')

for file in $ALL_FILES
do
	echo $file | grep "$ACTIVE_FILES" > /dev/null
	if [[ $? -ne 0 ]]
	then
		rm $BACKUP_DIR/$file
	fi
done
