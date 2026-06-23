#! /bin/bash


#Write a script that backs up a directory into a compressed archive. Make sure to only keep the latest 5 backups.Older backups automatically deleted and also log success/failure to backup.log file.

#1.write one command which creates the file backup.
#1.1 zip command
#1.2 file name in date format
#1.3 date should consists of day,month,year,time in hour,minutes,second. ex-18-june-2026-04:15:20.zip

#2.find latest backups.
#2.1 list down the backup directory.
#2.2 grep the latest 5 files in backup directory as per timestamp.

#3.find non-latest backups.
#3.1 list down the backup directory and grep the older backup files.
#3.2 remove the older backup files which are older than latest 5 backup files.

#4.write log
#4.1 write script output to a log file.


FILENAME=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_DIR=$1

zip -r  $FILENAME.zip $BACKUP_DIR 

