#! /bin/bash

STATUS_CODE="[2-5][0-9][0-9]"

LOGFILE=$1

DISTINCT_IPS=$(awk '{ print $1 }' $LOGFILE | sort | uniq | tr -d ',')

for IP in $DISTINCT_IPS; do
    COUNT=$(grep "$IP" $LOGFILE | grep -Eo "$STATUS_CODE" | sort | uniq)
    echo $IP $COUNT
done
