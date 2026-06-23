#! /bin/bash

FILE=$1
IP=$(cut -d "-" -f 1 $FILE | sort | uniq)

for ip in $IP
do
	STATUS_CODE=$(grep $ip $FILE | grep -oE "[2-5][1-9][1-9]" | sort | uniq)
	echo $ip $STATUS_CODE
done

