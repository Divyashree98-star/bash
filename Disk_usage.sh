#!/bin/bash
# Advanced Disk Usage Monitoring Script

THRESHOLD=80
LOGFILE="/var/log/disk_usage.log"
EMAIL="divyalbdivya123@gmail.com"

echo "------ $(date) ------" >> $LOGFILE

df -h --output=source,pcent,target | grep -v tmpfs | tail -n +2 | while read fs usage mount
do
    usage=${usage%\%}

    if [ $usage -ge $THRESHOLD ]; then
        echo "WARNING: Disk usage on $mount is ${usage}%" | tee -a $LOGFILE
        
        # Send Email Alert
        echo "Disk usage on $mount has reached ${usage}%" | mail -s "Disk Alert" $EMAIL
    else
        echo "OK: Disk usage on $mount is ${usage}%" >> $LOGFILE
    fi
done

