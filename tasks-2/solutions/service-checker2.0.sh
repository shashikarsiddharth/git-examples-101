#! /bin/bash

SERVICES_PATH=/etc/systemd/system/*

for svc in $@
do
    SVC_EXISTS=$(ls $SERVICES_PATH | grep $svc)
    if [[ -n $SVC_EXISTS ]]
    then
        STATUS=$(systemctl is-active $svc)
        if [[ "active" == $STATUS ]]
        then
                echo $svc: RUNNING
        else
                echo $svc: STOPPED
        fi
    else
        echo $svc: NOT EXISTS
    fi
done
