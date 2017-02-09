#!/bin/bash
set -e

# check if we should trust selfsigned certificates
if [ "$TRUST_SELFSIGN" -eq 1 ]; then
  SELFSIGN="--trust"
fi

# check if we should sync hidden files
if [ "$SYNC_HIDDEN" -eq 1 ]; then
	SYNCHIDDEN='-h'
fi

while true
do 
	su - occlient -c "owncloudcmd $SELFSIGN $SYNCHIDDEN -s -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_URLPATH$OC_WEBDAV$OC_FILEPATH"
	sleep $RUN_INTERVAL
done
