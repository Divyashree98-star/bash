#!/bin/bash

THRESHOLD=80

df -h | tail -n +2 | while read line
do
    usage=$(echo $line | awk '{print $5}' | sed 's/%//')
    partition=$(echo $line | awk '{print $6}')

    if [ $usage -ge $THRESHOLD ]; then
        echo "WARNING: Disk usage on $partition is ${usage}%"
    else
        echo "OK: Disk usage on $partition is ${usage}%"
    fi
done
