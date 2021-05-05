#!/bin/bash

PATH=$PATH:/usr/bin:/usr/sbin:/apps/eStreamer-eNcore
SECS=$(date +%s)
ESTREAMERLOGFILE=/apps/eStreamer-eNcore/estreamer.log
ESTREAMERRESTART=/apps/eStreamer-eNcore/estreamer-restarts.log
idletime=$(expr $SECS - $(date +%s -r $ESTREAMERLOGFILE))

echo -n "$(date) - Status check running.. " &>> $ESTREAMERRESTART
if [ "$idletime" -gt 300 ]
then
        echo "$(date) - eNcore Python process has been idle for: $idletime seconds" &>> $ESTREAMERRESTART
        echo "$(date) - Restarting..." &>> $ESTREAMERRESTART
        echo "Last 20 lines of old log:" &>> $ESTREAMERRESTART
        echo "" &>> $ESTREAMERRESTART
        /usr/bin/tail -n 20 $ESTREAMERLOGFILE >> $ESTREAMERRESTART
        /apps/eStreamer-eNcore/encore.sh
else
        echo "OK" &>> $ESTREAMERRESTART
fi
