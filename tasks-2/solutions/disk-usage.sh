#! /bin/bash

THRESHOLD=$1
DISK_USAGE=$(df -h /System/Volumes/Data | awk '{ print $5} ' | tail -n 1 | tr -d '%')

if [[ $DISK_USAGE -gt $1 ]]; then
  echo "WARNING: Alert Disk Usage exceeds ${THRESHOLD}: current usage ${DISK_USAGE}"
fi
