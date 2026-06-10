#! /bin/bash

for svc in $@
do
    STATUS=$(systemctl is-active $svc)
    if [[ "active" == $STATUS ]]
    then
        echo $svc: RUNNING
    else
        echo $svc: STOPPED
    fi
done
